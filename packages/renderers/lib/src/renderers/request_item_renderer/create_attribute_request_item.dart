import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/request_renderer_controller.dart';
import 'widgets/draft_attribute_renderer.dart';

class CreateAttributeRequestItemRenderer extends StatelessWidget {
  final CreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final bool isRejected;

  const CreateAttributeRequestItemRenderer({super.key, required this.item, this.controller, required this.isRejected});

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: item.attribute, isRejected: isRejected);
  }
}
