import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';

class CreateAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final CreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const CreateAttributeRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(
          text: 'Name: ',
          children: [TextSpan(text: item.attribute.name)],
        )),
        Text.rich(TextSpan(
          text: 'Description: ',
          children: [TextSpan(text: item.attribute.description)],
        )),
        Text.rich(TextSpan(
          text: 'Request ID: ',
          children: [TextSpan(text: request.id)],
        )),
        Text.rich(TextSpan(
          text: 'Status: ',
          children: [TextSpan(text: request.statusText)],
        )),
        Text.rich(TextSpan(
          text: 'Created by: ',
          children: [TextSpan(text: request.createdBy.name)],
        )),
        Text.rich(
          TextSpan(
            text: 'Created at: ',
            children: [TextSpan(text: DateTime.parse(request.createdAt).toString())],
          ),
        ),
        // TODO: children: [TextSpan(text: DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(request.createdAt)))],
      ],
    );
  }
}
