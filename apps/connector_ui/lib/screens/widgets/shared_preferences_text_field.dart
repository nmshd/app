import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesEnabledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String sharedPreferencesKey;

  const SharedPreferencesEnabledTextField({
    super.key,
    this.obscureText = false,
    required this.label,
    required this.controller,
    required this.sharedPreferencesKey,
  });

  @override
  State<SharedPreferencesEnabledTextField> createState() => _SharedPreferencesEnabledTextFieldState();
}

class _SharedPreferencesEnabledTextFieldState extends State<SharedPreferencesEnabledTextField> {
  bool _enabled = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sp = await GetIt.I.getAsync<SharedPreferences>();
      if (sp.containsKey(widget.sharedPreferencesKey)) {
        widget.controller.text = sp.getString(widget.sharedPreferencesKey)!;
        setState(() {
          _enabled = false;
        });
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        widget.controller.notifyListeners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(labelText: widget.label),
            obscureText: !_enabled && widget.obscureText,
            enabled: _enabled,
          ),
        ),
        IconButton(icon: Icon(_enabled ? Icons.lock_open : Icons.lock), onPressed: toggle),
      ],
    );
  }

  void toggle() {
    if (_enabled) {
      lock();
    } else {
      unlock();
    }
  }

  void lock() {
    final sp = GetIt.I.get<SharedPreferences>();
    sp.setString(widget.sharedPreferencesKey, widget.controller.text);

    setState(() {
      _enabled = false;
    });
  }

  void unlock() {
    final sp = GetIt.I.get<SharedPreferences>();
    sp.remove(widget.sharedPreferencesKey);

    setState(() {
      _enabled = true;
    });
  }
}
