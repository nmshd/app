import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../widgets/draft_attribute_renderer.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatelessWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final VoidCallback? onEdit;

  const DecidableProposeAttributeRequestItemRenderer({super.key, required this.item, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: item.attribute, onEdit: onEdit);
  }
}
