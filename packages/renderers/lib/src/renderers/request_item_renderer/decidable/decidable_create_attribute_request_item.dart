import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableCreateAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final DecidableCreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableCreateAttributeRequestItemRenderer({super.key, required this.request, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
