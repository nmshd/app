import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class CheckboxButton extends StatefulWidget {
  const CheckboxButton({super.key, required this.fieldName, this.initialValue, required this.values});

  final String fieldName;
  final List<ValueHintsValue> values;
  final dynamic initialValue;

  @override
  State<CheckboxButton> createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton> {
  late Map<dynamic, bool> isCheckedMap;

  @override
  void initState() {
    super.initState();
    isCheckedMap = {for (var item in widget.values) item.key: widget.initialValue?[item.key] ?? false};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.fieldName),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.values.length,
          itemBuilder: (context, index) {
            final valueKey = widget.values[index].key;
            return CheckboxListTile(
              title: Text(widget.values[index].key.toString()),
              value: isCheckedMap[valueKey],
              onChanged: (bool? value) {
                setState(() {
                  isCheckedMap[valueKey] = value ?? false;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
