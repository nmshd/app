import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableShareAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final DecidableShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableShareAttributeRequestItemRenderer({super.key, required this.request, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
