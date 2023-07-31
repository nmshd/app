import 'package:flutter/material.dart';

class DropdownSelectButton extends StatefulWidget {
  const DropdownSelectButton({super.key, this.fieldName = 'Select an Option: ', this.initialValue, this.values});

  final dynamic initialValue;
  final List<dynamic>? values;
  final String fieldName;

  @override
  State<DropdownSelectButton> createState() => _DropdownSelectButtonState();
}

class _DropdownSelectButtonState extends State<DropdownSelectButton> {
  late dynamic selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Text(widget.fieldName),
        ), // Label
        DropdownButton<dynamic>(
          value: selectedOption,
          onChanged: (dynamic newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          items: [
            DropdownMenuItem<dynamic>(
              value: widget.initialValue,
              child: Text(widget.initialValue),
            ),
            ...widget.values?.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value['key'],
                    child: Text(value['key'].toString()),
                  );
                }) ??
                []
          ],
        ),
      ],
    );
  }
}
