import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import '../widgets/draft_attribute_renderer.dart';

class DecidableShareAttributeRequestItemRenderer extends StatelessWidget {
  final DecidableShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableShareAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switch (item.attribute) {
          final DraftIdentityAttributeDVO dvo => DraftAttributeRenderer(draftAttribute: dvo),
          final DraftRelationshipAttributeDVO dvo => DraftAttributeRenderer(draftAttribute: dvo),
        },
        Text(item.attribute.name),
        const SizedBox(height: 30),
      ],
    );
  }
}
