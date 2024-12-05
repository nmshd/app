import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              controller: _controller,
              validator: (value) => value!.isEmpty ? context.l10n.passwordProtection_passwordEmpty : null,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                  icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                ),
              ),
              autofocus: true,
            ),
          ),
          Gaps.h24,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: context.pop, child: Text(context.l10n.cancel)),
              Gaps.w8,
              FilledButton(onPressed: _onPasswordEntered, child: Text(context.l10n.next)),
            ],
          )
        ],
      ),
    );
  }

  void _onPasswordEntered() {
    if (!formKey.currentState!.validate()) return;

    context.pop(_controller.text);
  }
}
