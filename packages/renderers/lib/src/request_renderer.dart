import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        Text.rich(TextSpan(
          text: 'Titel: ',
          children: [TextSpan(text: request.name)],
        )),
        Text.rich(TextSpan(
          text: 'Description: ',
          children: [TextSpan(text: request.description)],
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
            children: [TextSpan(text: DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(request.createdAt)))],
          ),
        ),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ],
    ));
  }
}
