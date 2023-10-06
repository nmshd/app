import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableConsentRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final DecidableConsentRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableConsentRequestItemRenderer({super.key, required this.request, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
