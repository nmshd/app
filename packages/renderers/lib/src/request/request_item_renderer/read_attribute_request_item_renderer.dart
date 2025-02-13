import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

class ReadAttributeRequestItemRenderer extends StatelessWidget {
  final ReadAttributeRequestItemDVO item;

  const ReadAttributeRequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // TODO: ?!?!?!!??
    return Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)));
  }
}
