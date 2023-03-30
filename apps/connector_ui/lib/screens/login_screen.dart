import 'dart:io';

import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_types/enmeshed_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:window_size/window_size.dart';

import 'widgets/shared_preferences_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final baseUrlController = TextEditingController();
  final apiKeyController = TextEditingController();

  bool _loginEnabled = false;
  bool _loginProcessing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    cb() => setState(() => _loginEnabled = !(baseUrlController.text.isEmpty || apiKeyController.text.isEmpty));
    baseUrlController.addListener(cb);
    apiKeyController.addListener(cb);
  }

  @override
  void dispose() {
    baseUrlController.dispose();
    apiKeyController.dispose();

    super.dispose();
  }

  void textUpdated() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SharedPreferencesEnabledTextField(
                label: 'Base URL',
                controller: baseUrlController,
                sharedPreferencesKey: 'baseurl',
              ),
              const SizedBox(height: 10),
              SharedPreferencesEnabledTextField(
                label: 'API Key',
                controller: apiKeyController,
                sharedPreferencesKey: 'apikey',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loginEnabled ? login : null,
                child: const Text('Login'),
              ),
              if (_loginProcessing || _errorMessage != null) const SizedBox(height: 10),
              if (_loginProcessing) const CircularProgressIndicator(),
              if (_errorMessage != null) Text(_errorMessage!),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      _errorMessage = null;
      _loginEnabled = false;
      _loginProcessing = true;
    });

    final baseUrl = baseUrlController.text;
    final apiKey = apiKeyController.text;

    final client = ConnectorClient(baseUrl, apiKey);

    final x = await client.account.getIdentityInfo().catchError((e) {
      final error = ConnectorError(id: 'id', docs: 'docs', time: 'time', code: 'network error', message: e.toString());
      return ConnectorResponse.fromError<types.GetIdentityInfoResponse>(error);
    });

    if (x.hasError) {
      final errorMessage = x.error.code == 'error.connector.unauthorized' ? 'Login failed: Invalid API key' : 'Login failed: ${x.error.code}';
      setState(() {
        _errorMessage = errorMessage;
      });

      if (context.mounted) {}

      setState(() {
        _loginEnabled = true;
        _loginProcessing = false;
      });
      return;
    }

    if (context.mounted) {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        setWindowTitle('Connector Management UI - $baseUrl');
      }

      GetIt.I.registerSingleton(client);
      Navigator.of(context).pushReplacementNamed('/main');
    }
  }
}
