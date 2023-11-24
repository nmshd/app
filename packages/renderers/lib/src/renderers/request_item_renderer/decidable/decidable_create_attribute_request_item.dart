import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../widgets/draft_attribute_renderer.dart';

class DecidableCreateAttributeRequestItemRenderer extends StatelessWidget {
  final DecidableCreateAttributeRequestItemDVO item;
  final VoidCallback? onEdit;

  const DecidableCreateAttributeRequestItemRenderer({super.key, required this.item, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: item.attribute, onEdit: onEdit);
  }
}
