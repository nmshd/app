import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class AttributeScreen extends StatefulWidget {
  final List<AttributeSwitcherChoice> choices;
  final AttributeSwitcherChoice? currentChoice;
  final ValueHints? valueHints;
  final String attributeTitle;

  const AttributeScreen({
    super.key,
    required this.choices,
    this.valueHints,
    required this.attributeTitle,
    this.currentChoice,
  });

  @override
  State<AttributeScreen> createState() => _AttributeScreenState();
}

class _AttributeScreenState extends State<AttributeScreen> {
  AttributeSwitcherChoice? selectedOption;

  @override
  void initState() {
    super.initState();

    selectedOption = widget.currentChoice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TranslatedText('i18n://dvo.attribute.name.${widget.attributeTitle}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Share an entry you have already created with your contact or create a new one for it.'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('My Entries', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add Entry'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: widget.choices.map((item) {
                return ColoredBox(
                  color: Colors.white,
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.valueHints != null)
                              Expanded(
                                child: AttributeRenderer(
                                  attribute: item.attribute,
                                  valueHints: widget.valueHints!,
                                  showTitle: false,
                                ),
                              ),
                            Radio<AttributeSwitcherChoice>(
                              value: item,
                              groupValue: selectedOption,
                              onChanged: (AttributeSwitcherChoice? value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        selectedOption = item;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: () => Navigator.pop(context, selectedOption),
                    child: const Text('Select'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
