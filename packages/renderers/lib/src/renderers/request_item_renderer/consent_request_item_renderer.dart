import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';

class ConsentRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final ConsentRequestItemDVO item;
  final RequestRendererController? controller;

  const ConsentRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(
          text: 'Name: ',
          children: [TextSpan(text: item.name)],
        )),
        Text.rich(TextSpan(
          text: 'Description: ',
          children: [TextSpan(text: item.description)],
        )),
        Text.rich(TextSpan(
          text: 'Date: ',
          children: [TextSpan(text: item.date)],
        )),
        Text.rich(TextSpan(
          text: 'Consent: ',
          children: [TextSpan(text: item.consent)],
        )),
        Text.rich(TextSpan(
          text: 'Link: ',
          children: [TextSpan(text: item.link)],
        )),
      ],
    );
  }
}
