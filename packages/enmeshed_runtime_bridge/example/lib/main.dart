import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal_bottom_sheet;
import 'package:permission_handler/permission_handler.dart';

import 'views/views.dart';

void main() async {
  enableFlutterDriverExtension();

  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final EnmeshedRuntime runtime;
  bool isLoading = true;
  bool runtimeReady = false;

  @override
  void initState() {
    super.initState();

    runtime = EnmeshedRuntime(runtimeReadyCallback: () {
      print('Runtime ready');
      setState(() {
        runtimeReady = true;
        isLoading = false;
      });
    })
      ..run();
  }

  @override
  void dispose() {
    super.dispose();
    runtime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enmeshed demo')),
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        child: const Icon(Icons.qr_code_scanner),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                      runtimeReady = false;
                    });

                    await runtime.dispose();
                    await runtime.run();
                  },
                  child: const Text('(re-)load runtime'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: showBottomSheet,
                  child: const Text('run evaluation on the runtime'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final content = await runtime.fs.listFiles('data', 'data');
                    print(content);
                  },
                  child: const Text('check filesystem'),
                ),
                const SizedBox(height: 20),
                if (isLoading) const CircularProgressIndicator(),
                if (isLoading) const SizedBox(height: 10),
                Text("Runtime ready: ${runtimeReady ? "✅" : "❌"}"),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    await onAccountServicesPressed();
                  },
                  child: const Text(
                    'Test: AccountServices',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onMessagesFacadePressed();
                  },
                  child: const Text(
                    'Test: MessagesFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onRelationshipsFacadePressed();
                  },
                  child: const Text(
                    'Test: RelationshipsFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onRelationshipTemplatesFacadePressed();
                  },
                  child: const Text(
                    'Test: RelationshipTemplatesFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onFilesFacadePressed();
                  },
                  child: const Text(
                    'Test: FilesFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onAccountFacadePressed();
                  },
                  child: const Text(
                    'Test: AccountFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onAttributesFacadePressed();
                  },
                  child: const Text(
                    'Test: AttributesFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onAttributeListenersFacadePressed();
                  },
                  child: const Text(
                    'Test: AttributeListenersFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onIncomingRequestsFacadePressed();
                  },
                  child: const Text(
                    'Test: IncomingRequestsFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await onOutgoingRequestsFacadePressed();
                  },
                  child: const Text(
                    'Test: OutgoingRequestsFacade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: RuntimeEvaluationArea(runtime: runtime),
      ),
      expand: true,
    );
  }

  Future<void> onFabPressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      context: context,
      builder: (_) => ScannerView(
        onDetected: (String truncatedReference) async {
          final item = await runtime.currentSession.transportServices.accounts.loadItemFromTruncatedReference(reference: truncatedReference);

          if (item.type != LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate) return;

          final template = item.relationshipTemplateValue;
          print(template);

          final relationship = await runtime.currentSession.transportServices.relationships.createRelationship(
            templateId: template.id,
            content: {},
          );

          print(relationship);
        },
      ),
    );
  }

  Future<void> onAccountServicesPressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => AccountServicesView(runtime: runtime),
    );
  }

  Future<void> onMessagesFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => MessagesFacadeView(runtime: runtime),
    );
  }

  Future<void> onRelationshipsFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => RelationshipsFacadeView(runtime: runtime),
    );
  }

  Future<void> onRelationshipTemplatesFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => RelationshipTemplatesFacadeView(runtime: runtime),
    );
  }

  Future<void> onAccountFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => AccountFacadeView(runtime: runtime),
    );
  }

  Future<void> onFilesFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => FilesFacadeView(runtime: runtime),
    );
  }

  Future<void> onAttributesFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => AttributesFacadeView(runtime: runtime),
    );
  }

  Future<void> onAttributeListenersFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => AttributeListenersFacadeView(runtime: runtime),
    );
  }

  Future<void> onIncomingRequestsFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => IncomingRequestsFacadeView(runtime: runtime),
    );
  }

  Future<void> onOutgoingRequestsFacadePressed() async {
    if (!runtime.isReady) return;

    await modal_bottom_sheet.showMaterialModalBottomSheet(
      shape: shape,
      context: context,
      builder: (context) => OutgoingRequestsFacadeView(runtime: runtime),
    );
  }

  ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
  );
}
