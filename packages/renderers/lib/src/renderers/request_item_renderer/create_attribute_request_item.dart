import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/identity_attribute_renderer.dart';

import '../../request_renderer.dart';
import 'widgets/relationship_attribute_renderer.dart';

class CreateAttributeRequestItemRenderer extends StatelessWidget {
  final CreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const CreateAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switch (item.attribute) {
          final DraftIdentityAttributeDVO dvo => DraftIdentityAttributeRenderer(attribute: dvo),
          final DraftRelationshipAttributeDVO dvo => DraftRelationshipAttributeRenderer(attribute: dvo),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
