import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import 'widgets/renderers/request_item_group_renderer/request_item_group_renderer.dart';
import 'widgets/renderers/request_item_group_renderer/request_item_renderer/request_item_renderer.dart';

class RequestRendererController extends ValueNotifier<dynamic> {
  RequestRendererController() : super(null);
}

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO? request;

  const RequestRenderer({super.key, this.controller, this.request});

  @override
  Widget build(BuildContext context) {
    final requestItems = request!.items;
    print(requestItems);

    for (final item in requestItems) {
      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(requestItemGroup: item);
      }

      return RequestItemRenderer(item: item, controller: controller);
    }

    throw Exception('Cannot render with empty request');
  }
}
