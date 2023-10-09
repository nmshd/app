import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'renderers/request_item_group_renderer.dart';
import 'renderers/request_item_renderer/request_item_renderer.dart';
import 'renderers/request_item_renderer/response/response.dart';

class RequestRendererController extends ValueNotifier<dynamic> {
  RequestRendererController() : super(null);
}

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO request;

  const RequestRenderer({super.key, this.controller, required this.request});

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> requestItems = [];
    List<StatelessWidget> responseItems = [];

    requestItems = request.items.map((item) {
      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(requestItemGroup: item);
      }

      return RequestItemRenderer(item: item, controller: controller);
    }).toList();

    if (request.response != null) {
      responseItems = request.response!.content.items.map((item) {
        if (item is ResponseItemGroupDVO) {
          return ResponseItemGroupRenderer(responseItemGroup: item, requestItems: request.items);
        }

        return ResponseItemRenderer(item: item, requestItems: request.items);
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems.isNotEmpty ? responseItems : requestItems),
    );
  }
}
