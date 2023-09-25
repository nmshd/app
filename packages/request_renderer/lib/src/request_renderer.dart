import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import 'widgets/renderers/request_item_group_renderer/request_item_group_renderer.dart';
import 'widgets/renderers/request_item_group_renderer/request_item_renderer/request_item_renderer.dart';

class RequestRendererController extends ValueNotifier<dynamic> {
  RequestRendererController() : super(null);
}

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final RequestDVO? request;

  const RequestRenderer({super.key, this.controller, this.request});

  @override
  Widget build(BuildContext context) {
    final requestItems = request!.items;

    for (final item in requestItems) {
      if (item.type == 'RequestItemGroupDVO') {
        return const RequestItemGroupRenderer();
      }
      return RequestItemRenderer(item: item);
    }

    throw Exception('Cannot render with empty request');
  }
}
