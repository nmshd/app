import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'renderers/request_item_group_renderer.dart';
import 'renderers/request_item_renderer/request_item_renderer.dart';
import 'renderers/request_item_renderer/response/response.dart';

class RequestRendererController extends ValueNotifier<DecideRequestParameters?> {
  RequestRendererController() : super(null);
}

typedef RequestItemIndex = ({
  int rootIndex,
  int? groupIndex,
});

class RequestRenderer extends StatefulWidget {
  late RequestRendererController _controller;
  final LocalRequestDVO request;
  final VoidCallback? onEdit;
  final RequestValidationResultDTO? validationResult;
  //same structure as items

  RequestRenderer({
    super.key,
    RequestRendererController? controller,
    required this.request,
    this.onEdit,
    this.validationResult,
  }) {
    _controller = controller ?? RequestRendererController();
  }

  @override
  State<RequestRenderer> createState() => _RequestRendererState();
}

class _RequestRendererState extends State<RequestRenderer> {
  @override
  void initState() {
    super.initState();

    final items = composeItems(widget.request);
    widget._controller.value = DecideRequestParameters(requestId: widget.request.id, items: items);
  }

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> requestItems = [];
    List<StatelessWidget> responseItems = [];

    requestItems = widget.request.items.map((item) {
      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(requestItemGroup: item, controller: widget._controller, onEdit: widget.onEdit);
      }

      return RequestItemRenderer(item: item, controller: widget._controller, onEdit: widget.onEdit);
    }).toList();

    if (widget.request.response != null) {
      responseItems = widget.request.response!.content.items.map((item) {
        if (item is ResponseItemGroupDVO) return ResponseItemGroupRenderer(responseItemGroup: item, requestItems: widget.request.items);

        return ResponseItemRenderer(item: item, requestItems: widget.request.items);
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems.isNotEmpty ? responseItems : requestItems),
    );
  }

  List<DecideRequestParametersItem> composeItems(LocalRequestDVO request) {
    return request.items.map((e) {
      if (e is RequestItemGroupDVO) {
        return DecideRequestItemGroupParameters(items: e.items.map((e) => const RejectRequestItemParameters()).toList());
      }

      return const RejectRequestItemParameters();
    }).toList();
  }
}
