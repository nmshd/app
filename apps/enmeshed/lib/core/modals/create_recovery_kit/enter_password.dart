import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/extensions.dart';
import '../../widgets/widgets.dart';

class EnterPassword extends StatefulWidget {
  final void Function(String password) onPasswordEntered;

  const EnterPassword({required this.onPasswordEntered, super.key});

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: max(MediaQuery.paddingOf(context).bottom, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.identityRecovery_passwordDescription),
          Gaps.h24,
          InformationContainer(title: context.l10n.identityRecovery_passwordAttention),
          Gaps.h36,
          Form(
            key: _formKey,
            child: Column(
              children: [
                _PasswordTextField(
                  inputControl: _passwordController,
                  label: context.l10n.identityRecovery_password,
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.identityRecovery_passwordEmptyError;
                    return null;
                  },
                ),
                Gaps.h24,
                _PasswordTextField(
                  inputControl: _confirmPasswordController,
                  label: context.l10n.identityRecovery_passwordConfirm,
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.identityRecovery_passwordEmptyError;
                    if (value != _passwordController.text) return context.l10n.identityRecovery_passwordMismatch;
                    return null;
                  },
                ),
                Gaps.h48,
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: _onSubmit,
                    child: Text(context.l10n.identityRecovery_startNow),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onPasswordEntered(_passwordController.text);
  }
}

class _PasswordTextField extends StatefulWidget {
  final TextEditingController inputControl;
  final String label;
  final String? Function(String?) validator;

  const _PasswordTextField({
    required this.inputControl,
    required this.label,
    required this.validator,
  });

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputControl,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      validator: widget.validator,
    );
  }
}
