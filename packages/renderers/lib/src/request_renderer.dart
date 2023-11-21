import 'package:collection/collection.dart';
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
  final VoidCallback? onEdit;

  const RequestRenderer({super.key, this.controller, required this.request, this.onEdit});

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> requestItems = [];
    List<StatelessWidget> responseItems = [];

    requestItems = request.items.map((item) {
      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(requestItemGroup: item, controller: controller, onEdit: onEdit);
      }

      return RequestItemRenderer(item: item, controller: controller, onEdit: onEdit);
    }).toList();

    if (request.response != null) {
      responseItems = request.response!.content.items.mapIndexed((index, item) {
        if (item is ResponseItemGroupDVO) {
          final requestItemGroup = request.items[index] as RequestItemGroupDVO;
          return ResponseItemGroupRenderer(responseItemGroup: item, requestItemGroup: requestItemGroup);
        }

        return ResponseItemRenderer(responseItem: item, requestItem: request.items[index]);
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems.isNotEmpty ? responseItems : requestItems),
    );
  }
}
