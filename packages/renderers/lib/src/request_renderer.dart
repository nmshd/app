import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

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
    print(requestItems);

    final items = requestItems.map((item) {
      if (item is RequestItemGroupDVO) {
        print('it is a RequestItemGroupDVO');
        return RequestItemGroupRenderer(request: request, requestItemGroup: item);
      }

      print('it is a RequestItemDVO');
      return RequestItemRenderer(request: request, item: item, controller: controller);

      // throw Exception('Cannot render with empty request');
    }).toList();

    return SingleChildScrollView(child: Column(children: items));
  }
}
