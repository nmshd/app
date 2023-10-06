import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:translated_text/translated_text.dart';

import 'renderers/request_item_group_renderer.dart';
import 'renderers/request_item_renderer/request_item_renderer.dart';

class RequestRendererController extends ValueNotifier<dynamic> {
  RequestRendererController() : super(null);
}

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO request;

  const RequestRenderer({super.key, this.controller, required this.request});

  @override
  Widget build(BuildContext context) {
    final requestItems = request.items;

    final items = requestItems.map((item) {
      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(request: request, requestItemGroup: item);
      }

      return RequestItemRenderer(request: request, item: item, controller: controller);
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
          TranslatedText(request.name),
          if (request.description != null) ...[
            const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
            TranslatedText(request.description!)
          ],
          const Text('Request ID:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(request.id),
          const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
          TranslatedText(request.statusText),
          const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(request.createdBy.name),
          const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(request.createdAt))),
          const Divider(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: items),
        ],
      ),
    );
  }
}
