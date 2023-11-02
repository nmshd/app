import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../request_renderer.dart';
import 'widgets/draft_attribute_renderer.dart';

class CreateAttributeRequestItemRenderer extends StatelessWidget {
  final CreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const CreateAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: item.attribute);
  }
}
