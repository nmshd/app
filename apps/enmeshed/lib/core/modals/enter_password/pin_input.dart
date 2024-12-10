import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:go_router/go_router.dart';

class PinInput extends StatefulWidget {
  final int pinLength;

  const PinInput({required this.pinLength, super.key});

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  final _focusNode = FocusNode();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pinLength >= 4 && widget.pinLength <= 6) {
      return PinCodeFields(
        length: widget.pinLength,
        obscureText: _obscureText,
        onComplete: context.pop,
        keyboardType: TextInputType.number,
        focusNode: _focusNode,
        borderRadius: BorderRadius.circular(4),
        fieldHeight: 56,
        fieldWidth: 40,
        responsive: false,
        borderColor: Theme.of(context).colorScheme.primary,
        activeBorderColor: Theme.of(context).colorScheme.primary,
        activeBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        fieldBorderStyle: FieldBorderStyle.square,
        textStyle: Theme.of(context).textTheme.displaySmall!,
        obscureCharacter: '•',
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        obscureText: _obscureText,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () => setState(() => _obscureText = !_obscureText),
            icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          ),
        ),
        style: Theme.of(context).textTheme.headlineSmall,
        maxLength: widget.pinLength,
        autofocus: true,
        onChanged: (text) {
          if (text.length != widget.pinLength) return;
          context.pop(text);
        },
      ),
    );
  }
}
