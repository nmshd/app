import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/renderers.dart';
import '../widgets/draft_attribute_renderer.dart';

class DecidableShareAttributeRequestItemRenderer extends StatelessWidget {
  final DecidableShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableShareAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: item.attribute);
  }
}
