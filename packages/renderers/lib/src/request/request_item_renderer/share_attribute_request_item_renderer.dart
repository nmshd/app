import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/attribute/draft_attribute_renderer.dart';

class ShareAttributeRequestItemRenderer extends StatelessWidget {
  final ShareAttributeRequestItemDVO item;
  final bool isRejected;
  final Future<FileDVO> Function(String) expandFileReference;

  const ShareAttributeRequestItemRenderer({
    super.key,
    required this.item,
    required this.isRejected,
    required this.expandFileReference,
  });

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(
      draftAttribute: item.attribute,
      isRejected: isRejected,
      expandFileReference: expandFileReference,
    );
  }
}
