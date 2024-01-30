import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/attribute/draft_attribute_renderer.dart';

class ShareAttributeRequestItemRenderer extends StatelessWidget {
  final ShareAttributeRequestItemDVO item;
  final bool isRejected;

  const ShareAttributeRequestItemRenderer({
    super.key,
    required this.item,
    required this.isRejected,
  });

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: item.attribute, isRejected: isRejected);
  }
}
