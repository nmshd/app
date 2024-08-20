import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:feature_flags/feature_flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:push/push.dart';

import '/core/core.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DEBUG')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              builder: (_, s) => !s.hasData ? const CircularProgressIndicator() : _CopyableText(title: 'Address: ', text: s.data!.value.address),
              future: GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.account.getIdentityInfo(),
            ),
            FutureBuilder(
              builder: (_, s) => !s.hasData ? const CircularProgressIndicator() : _CopyableText(title: 'Push Token: ', text: s.data!),
              future: Push.instance.token.timeout(const Duration(seconds: 5)).catchError((_) => 'timeout', test: (e) => e is TimeoutException),
            ),
            // the view is also accessible in release mode but feature flags and clear profile may not be available there
            if (kDebugMode) ...[
              OutlinedButton(
                onPressed: () => DebugFeatures.show(
                  context,
                  availableFeatures: [
                    const Feature('NEWS', name: 'News'),
                    const Feature('BACKUP_DATA', name: 'Backup Data'),
                    const Feature('HELP_AND_FAQ', name: 'Help and FAQ'),
                    const Feature('SHOW_TECHNICAL_MESSAGES', name: 'Show Technical Messages'),
                    const Feature('SHOW_CONTACT_REQUESTS', name: 'Show Contact Requests'),
                  ],
                ),
                child: const Text('Feature Flags'),
              ),
              const Divider(indent: 20, endIndent: 20, height: 20, thickness: 1.5),
              OutlinedButton(
                onPressed: () async => _clearProfiles(context),
                child: const Text('Clear Profiles'),
              ),
            ],
            const Divider(indent: 20, endIndent: 20, height: 20, thickness: 1.5),
            OutlinedButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (context) => const SafeArea(minimum: EdgeInsets.only(bottom: 16), child: _PushDebugger()),
              ),
              child: const Text('Push Debugger'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _clearProfiles(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all Profiles?'),
        content: const Text('This will delete all profiles and their data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == null || !confirmed) return;

    if (context.mounted) unawaited(showLoadingDialog(context, 'Deleting all Profiles...'));

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final accounts = await runtime.accountServices.getAccounts();
    for (final account in accounts) {
      await runtime.accountServices.deleteAccount(account.id);
    }

    final dir = await getApplicationDocumentsDirectory();

    final databaseFolder = Directory('${dir.path}/${runtime.runtimeConfig.databaseFolder}');
    if (databaseFolder.existsSync()) {
      await databaseFolder.delete(recursive: true);
    }

    final cacheFolder = Directory('${dir.path}/cache');
    if (cacheFolder.existsSync()) {
      await cacheFolder.delete(recursive: true);
    }

    if (context.mounted) context.go('/onboarding');
  }
}

class _CopyableText extends StatelessWidget {
  final String title;
  final String text;

  const _CopyableText({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          text.length > 15 ? '${text.substring(0, 15)}...' : text,
          style: text == 'timeout' ? TextStyle(color: Theme.of(context).colorScheme.error) : null,
        ),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: text == 'timeout' ? null : () => Clipboard.setData(ClipboardData(text: text)),
        ),
      ],
    );
  }
}

class _PushDebugger extends StatefulWidget {
  const _PushDebugger();

  @override
  State<_PushDebugger> createState() => _PushDebuggerState();
}

class _PushDebuggerState extends State<_PushDebugger> {
  final unsubscribeFunctions = <VoidCallback>[];
  final messages = <(DateTime, RemoteMessage)>[];
  static const _encoder = JsonEncoder.withIndent('  ');

  @override
  void initState() {
    super.initState();

    void cb(RemoteMessage message) => setState(() => messages.add((DateTime.now(), message)));
    unsubscribeFunctions.addAll([Push.instance.addOnMessage(cb), Push.instance.addOnBackgroundMessage(cb)]);
  }

  @override
  void dispose() {
    for (final unsubscribe in unsubscribeFunctions) {
      unsubscribe.call();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('Push Debugger', style: Theme.of(context).textTheme.labelLarge),
                const Align(alignment: Alignment.centerRight, child: CloseButton()),
              ],
            ),
          ),
          Expanded(
            child: messages.isEmpty
                ? const EmptyListIndicator(icon: Icons.message, text: 'No Push Notification received yet.', backgroundColor: Colors.transparent)
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) => ExpansionTile(
                      title: Text(DateFormat.Hms(Localizations.localeOf(context).languageCode).format(messages[index].$1)),
                      children: [Text(_encoder.convert(messages[index].$2.data))],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
