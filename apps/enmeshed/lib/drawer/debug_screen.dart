import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:feature_flags/feature_flags.dart';
import 'package:file_picker/file_picker.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                builder: (_, s) => !s.hasData ? const CircularProgressIndicator() : _CopyableText(title: 'Address: ', text: s.data!.value.address),
                future: () async {
                  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
                  final lastUsedAccount = accounts.reduce(
                    (value, element) => (value.lastAccessedAt ?? '').compareTo(element.lastAccessedAt ?? '') == 1 ? value : element,
                  );
                  final session = GetIt.I.get<EnmeshedRuntime>().getSession(lastUsedAccount.id);

                  return session.transportServices.account.getIdentityInfo();
                }(),
              ),
              FutureBuilder(
                builder: (_, s) => !s.hasData ? const CircularProgressIndicator() : _CopyableText(title: 'Push Token: ', text: s.data!),
                future: Push.instance.token.timeout(const Duration(seconds: 5)).catchError((_) => 'timeout', test: (e) => e is TimeoutException),
              ),
              if (kDebugMode) const _PasswordTester(),
              const Divider(indent: 20, endIndent: 20, height: 20, thickness: 1.5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 8,
                  children: [
                    if (kDebugMode) ...[
                      OutlinedButton(
                        onPressed: () => DebugFeatures.show(
                          context,
                          availableFeatures: [const Feature('SHOW_TECHNICAL_MESSAGES', name: 'Show Technical Messages')],
                        ),
                        child: const Text('Feature Flags'),
                      ),
                      OutlinedButton(onPressed: () async => _clearProfiles(context), child: const Text('Clear Profiles')),
                    ],
                    OutlinedButton(
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const SafeArea(minimum: EdgeInsets.only(bottom: 16), child: _PushDebugger()),
                      ),
                      child: const Text('Push Debugger'),
                    ),
                    OutlinedButton(onPressed: _extractAppDataAsZip, child: const Text('Export App Data')),
                  ],
                ),
              ),
            ],
          ),
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
          TextButton(onPressed: () => context.pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => context.pop(true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == null || !confirmed) return;

    if (context.mounted) unawaited(showLoadingDialog(context, 'Deleting all Profiles...'));

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final accounts = await runtime.accountServices.getAccounts();
    for (final account in accounts) {
      await runtime.accountServices.offboardAccount(account.id);
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

  Future<void> _extractAppDataAsZip() async {
    final dir = await getApplicationDocumentsDirectory();
    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final zipFile = File('${dir.path}/app_data.zip');

    final encoder = ZipFileEncoder()..create(zipFile.path);

    final databaseDir = Directory('${dir.path}/${runtime.runtimeConfig.databaseFolder}');
    if (databaseDir.existsSync()) await encoder.addDirectory(databaseDir);

    final cacheDir = Directory('${dir.path}/cache');
    if (cacheDir.existsSync()) await encoder.addDirectory(cacheDir);

    await encoder.addFile(File('${dir.path}/config.json'));

    encoder.closeSync();

    final bytes = zipFile.readAsBytesSync();

    final deviceDir = await FilePicker.platform.saveFile(
      fileName: 'app_data.zip',
      allowedExtensions: ['zip'],
      bytes: Platform.isIOS || Platform.isAndroid ? bytes : null,
    );

    if (Platform.isIOS || Platform.isAndroid || deviceDir == null) {
      await zipFile.delete();
      return;
    }

    final savedFile = File(deviceDir);
    await savedFile.writeAsBytes(bytes);
    await zipFile.delete();
  }
}

class _CopyableText extends StatelessWidget {
  final String title;
  final String text;

  const _CopyableText({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                text,
                style: text == 'timeout' ? TextStyle(color: Theme.of(context).colorScheme.error) : null,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: text == 'timeout' ? null : () => Clipboard.setData(ClipboardData(text: text)),
          ),
        ],
      ),
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

class _PasswordTester extends StatefulWidget {
  const _PasswordTester();

  @override
  State<_PasswordTester> createState() => _PasswordTesterState();
}

class _PasswordTesterState extends State<_PasswordTester> {
  bool _secondAttempt = false;
  String? _locationIndicator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(indent: 20, endIndent: 20, height: 20, thickness: 1.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text('Enter Password Popups', style: Theme.of(context).textTheme.titleLarge),
        ),
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          value: _secondAttempt,
          onChanged: (_) => setState(() => _secondAttempt = !_secondAttempt),
          title: const Text('Second Attempt'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            spacing: 8,
            children: [
              Flexible(child: Text('Location Indicator', style: Theme.of(context).textTheme.bodyLarge)),
              DropdownButton<String?>(
                value: _locationIndicator,
                items: const [
                  DropdownMenuItem(child: Text('None')),
                  DropdownMenuItem(value: 'RecoveryKit', child: Text('RecoveryKit')),
                  DropdownMenuItem(value: 'Self', child: Text('Self')),
                  DropdownMenuItem(value: 'Letter', child: Text('Letter')),
                  DropdownMenuItem(value: 'RegistrationLetter', child: Text('RegistrationLetter')),
                  DropdownMenuItem(value: 'Email', child: Text('Email')),
                  DropdownMenuItem(value: 'SMS', child: Text('SMS')),
                  DropdownMenuItem(value: 'Website', child: Text('Website')),
                ],
                onChanged: (value) => setState(() => _locationIndicator = value),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Wrap(
            spacing: 8,
            children: [
              for (int i = 4; i <= 16; i++) OutlinedButton(onPressed: () => _trigger(i), child: Text('PIN$i')),
              OutlinedButton(onPressed: () => _trigger(null), child: const Text('PW')),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _trigger(int? pinLength) async {
    final pin = await context.push(
      '/enter-password-popup',
      extra: (
        passwordType: pinLength != null ? UIBridgePasswordType.pin : UIBridgePasswordType.password,
        pinLength: pinLength,
        attempt: _secondAttempt ? 2 : 1,
        passwordLocationIndicator: switch (_locationIndicator) {
          'RecoveryKit' => 0,
          'Self' => 1,
          'Letter' => 2,
          'RegistrationLetter' => 3,
          'Email' => 4,
          'SMS' => 5,
          'Website' => 6,
          _ => null,
        },
      ),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entered PIN Code: $pin')));
  }
}
