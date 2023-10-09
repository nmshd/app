import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import '../widgets/identity_attribute_renderer.dart';
import '../widgets/relationship_attribute_renderer.dart';

class DecidableShareAttributeRequestItemRenderer extends StatelessWidget {
  final DecidableShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableShareAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (item.attribute) {
          final DraftIdentityAttributeDVO dvo => DraftIdentityAttributeRenderer(attribute: dvo),
          final DraftRelationshipAttributeDVO dvo => DraftRelationshipAttributeRenderer(attribute: dvo),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
