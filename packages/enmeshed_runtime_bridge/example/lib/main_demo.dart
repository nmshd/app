import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal_bottom_sheet;
import 'package:permission_handler/permission_handler.dart';

import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final EnmeshedRuntime runtime;
  bool runtimeReady = false;

  List<RelationshipDTO> relationships = [];
  List<MessageDTO> messages = [];
  List<LocalRequestDTO> requests = [];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    runtime = EnmeshedRuntime(() async {
      await reloadData(false);

      setState(() {
        runtimeReady = true;
      });
    })
      ..run();

    _tabController = TabController(length: 3, vsync: this)..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    runtime.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!runtimeReady) {
      return Scaffold(
        appBar: AppBar(title: const Text('Enmeshed demo')),
        body: const SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }

    final fab = _tabController.index < 2
        ? FloatingActionButton(
            onPressed: _tabController.index == 0 ? qrPressed : messageSendPressed,
            child: Icon(_tabController.index == 0 ? Icons.qr_code_scanner : Icons.send),
          )
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enmeshed Flutter Demo'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () => reloadData(true))],
        bottom: TabBar(
          tabs: const [
            Tab(icon: Icon(Icons.people)),
            Tab(icon: Icon(Icons.message)),
            Tab(icon: Icon(Icons.feedback)),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: fab,
      body: TabBarView(
        controller: _tabController,
        children: [
          RelationshipsView(relationships: relationships),
          MessagesView(messages: messages),
          RequestsView(requests: requests, runtime: runtime),
        ],
      ),
    );
  }

  void qrPressed() async {
    await modal_bottom_sheet.showMaterialModalBottomSheet(
      context: context,
      builder: (_) => ScannerView(
        onDetected: (String truncatedReference) async {
          final item = await runtime.currentSession.transportServices.accounts.loadItemFromTruncatedReference(reference: truncatedReference);

          if (item.type != LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate) return;

          final template = item.relationshipTemplateValue;
          await runtime.currentSession.transportServices.relationships.createRelationship(
            templateId: template.id,
            content: {},
          );

          await reloadData(false);
        },
      ),
    );
  }

  Future<void> reloadData(bool sync) async {
    if (sync) {
      await runtime.currentSession.transportServices.accounts.syncEverything();
    }

    messages = await runtime.currentSession.transportServices.messages.getMessages();
    relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
    requests = [...await runtime.currentSession.consumptionServices.incomingRequests.getRequests()];

    setState(() {});
  }

  Future<void> messageSendPressed() async {
    final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
    if (relationships.isEmpty) return;

    final child = SendMailView(
      onTriggerSend: (String subject, String body) async {
        await runtime.currentSession.transportServices.messages.sendMessage(
          recipients: [relationships.first.peer],
          content: Mail(body: body, subject: subject, to: [relationships.first.peer]).toJson(),
        );

        await reloadData(false);
      },
    );
    // ignore: use_build_context_synchronously
    await modal_bottom_sheet.showMaterialModalBottomSheet(
      context: context,
      bounce: true,
      builder: (context) => SingleChildScrollView(
        controller: modal_bottom_sheet.ModalScrollController.of(context),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      ),
    );
  }
}

class SendMailView extends StatelessWidget {
  final void Function(String body, String subject) onTriggerSend;

  SendMailView({super.key, required this.onTriggerSend});

  final subjectController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Subject'),
                  onSubmitted: (_) => send(context),
                  controller: subjectController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Body'),
                  onSubmitted: (_) => send(context),
                  controller: bodyController,
                ),
              ],
            ),
          ),
        ),
        IconButton(icon: const Icon(Icons.send), onPressed: () => send(context)),
      ],
    );
  }

  void send(context) {
    final subject = subjectController.text;
    final body = bodyController.text;
    if (subject == '' || body == '') return;

    onTriggerSend(subject, body);
    Navigator.of(context).pop();
  }
}

class RelationshipsView extends StatelessWidget {
  final List<RelationshipDTO> relationships;

  const RelationshipsView({super.key, required this.relationships});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(4),
      children: [
        for (final relationship in relationships)
          ListTile(
            title: Text(relationship.peer),
            subtitle: Text(relationship.status.name),
          ),
      ],
    );
  }
}

class MessagesView extends StatelessWidget {
  final List<MessageDTO> messages;

  const MessagesView({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    final messagesToDisplay = messages.where((e) => e.content is Mail).toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return ListView(
      padding: const EdgeInsets.all(4),
      children: [
        for (final message in messagesToDisplay)
          ListTile(
            title: Text((message.content as Mail).subject),
            subtitle: Text((message.content as Mail).body),
            leading: Icon(message.isOwn ? Icons.upload : Icons.download),
          ),
      ],
    );
  }
}

class RequestsView extends StatelessWidget {
  final List<LocalRequestDTO> requests;
  final EnmeshedRuntime runtime;

  const RequestsView({super.key, required this.requests, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(4),
      children: [
        for (final request in requests)
          ListTile(
            title: Text(request.peer),
            subtitle: Text('Status: ${request.status.name}'),
            leading: Icon(request.isOwn ? Icons.arrow_upward : Icons.arrow_downward),
            onTap: request.isOwn ? null : () async => await requestTapped(request, context),
          ),
      ],
    );
  }

  Future<void> requestTapped(LocalRequestDTO request, BuildContext context) async {
    await modal_bottom_sheet.showMaterialModalBottomSheet(
      context: context,
      builder: (context) => RequestView(runtime: runtime, request: request),
    );
  }
}

class RequestView extends StatelessWidget {
  final LocalRequestDTO request;
  final EnmeshedRuntime runtime;

  const RequestView({super.key, required this.request, required this.runtime});

  @override
  Widget build(BuildContext context) {
    final isDecidable = request.status == LocalRequestStatus.ManualDecisionRequired;

    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(child: Column(children: request.content.items.map((e) => Text(e.runtimeType.toString())).toList())),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isDecidable)
                  IconButton(
                    onPressed: () async => await onAcceptPressed(context),
                    icon: const Icon(Icons.check, color: Colors.green),
                  ),
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.do_not_disturb)),
                if (isDecidable)
                  IconButton(
                    onPressed: () async => await onRejectPressed(context),
                    icon: const Icon(Icons.close, color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onAcceptPressed(BuildContext context) async {
    // await runtime.currentSession.consumptionServices.incomingRequests.accept();

    if (context.mounted) Navigator.of(context).pop();
  }

  Future<void> onRejectPressed(BuildContext context) async {
    final items = request.content.items.map((e) {
      if (e is RequestItemGroup) {
        return DecideRequestItemGroupParameters(items: e.items.map((itemDerivation) => RejectRequestItemParameters()).toList());
      }

      return RejectRequestItemParameters();
    }).toList();

    await runtime.currentSession.consumptionServices.incomingRequests.reject(
      params: DecideRequestParameters(
        requestId: request.id,
        items: items,
      ),
    );

    if (context.mounted) Navigator.of(context).pop();
  }
}
