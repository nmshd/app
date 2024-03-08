import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/draft_attribute_renderer.dart';

class CreateAttributeRequestItemRenderer extends StatelessWidget {
  final CreateAttributeRequestItemDVO item;
  final bool isRejected;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const CreateAttributeRequestItemRenderer({
    super.key,
    required this.item,
    required this.isRejected,
    required this.expandFileReference,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(
      draftAttribute: item.attribute,
      isRejected: isRejected,
      expandFileReference: expandFileReference,
      openFileDetails: openFileDetails,
    );
  }
}
