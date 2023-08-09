import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class DropdownSelectButton extends StatefulWidget {
  final dynamic initialValue;
  final List<ValueHintsValue>? values;
  final String fieldName;

  const DropdownSelectButton({super.key, this.fieldName = 'Select an Option: ', this.initialValue, this.values});

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
          items: widget.values?.map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value.key,
                  child: Text(value.key.toString()),
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }
}
