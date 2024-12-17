import 'dart:math';

import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';
import '../../constants.dart';
import '../../widgets/widgets.dart';

class CreatePassword extends StatefulWidget {
  final void Function(String password) onContinue;

  const CreatePassword({required this.onContinue, super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final form = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

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
            key: form,
            child: Column(
              children: [
                _PasswordTextField(
                  inputControl: _passwordController,
                  label: context.l10n.identityRecovery_password,
                  obscureText: _passwordVisible,
                  onIconTap: () => setState(() => _passwordVisible = !_passwordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.identityRecovery_passwordEmptyError;
                    return null;
                  },
                ),
                Gaps.h24,
                _PasswordTextField(
                  inputControl: _confirmPasswordController,
                  label: context.l10n.identityRecovery_passwordConfirm,
                  obscureText: _confirmPasswordVisible,
                  onIconTap: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.identityRecovery_passwordEmptyError;
                    if (value != _passwordController.text) return context.l10n.identityRecovery_passwordError;
                    return null;
                  },
                ),
                Gaps.h48,
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: () {
                      if (form.currentState!.validate()) widget.onContinue(_passwordController.text);
                    },
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
}

class _PasswordTextField extends StatelessWidget {
  final TextEditingController inputControl;
  final String label;
  final bool obscureText;
  final VoidCallback onIconTap;
  final String? Function(String?) validator;

  const _PasswordTextField({
    required this.inputControl,
    required this.label,
    required this.obscureText,
    required this.onIconTap,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputControl,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: onIconTap,
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
      validator: validator,
    );
  }
}
