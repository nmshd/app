import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'widgets/identity_attribute_renderer.dart';

class ShareAttributeRequestItemRenderer extends StatelessWidget {
  final ShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ShareAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DraftIdentityAttributeRenderer(attribute: item.attribute);
  }
}
