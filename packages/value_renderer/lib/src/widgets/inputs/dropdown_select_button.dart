import 'package:flutter/material.dart';

class DropdownSelectButton extends StatefulWidget {
  const DropdownSelectButton({super.key, this.fieldName = 'Select an Option: ', this.initialValue = '', this.values});

  final String initialValue;
  final List<dynamic>? values;
  final String fieldName;

  @override
  State<DropdownSelectButton> createState() => _DropdownSelectButtonState();
}

class _DropdownSelectButtonState extends State<DropdownSelectButton> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Text(widget.fieldName),
        ), // Label
        DropdownButton<String>(
          value: selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          items: [
            DropdownMenuItem<String>(
              value: widget.initialValue,
              child: Text(widget.initialValue),
            ),
            ...widget.values?.map<DropdownMenuItem<String>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value['key'],
                    child: Text(value['key']),
                  );
                }) ??
                []
          ],
        ),
      ],
    );
  }
}
