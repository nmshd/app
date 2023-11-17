import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/request_renderer_controller.dart';
import 'renderers/request_item_group_renderer.dart';
import 'renderers/request_item_renderer/request_item_renderer.dart';
import 'renderers/request_item_renderer/response/response.dart';

class RequestRenderer extends StatefulWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO request;
  final VoidCallback? onEdit;
  final RequestValidationResultDTO? validationResult;
  final Future<AbstractAttribute> Function()? selectAttribute;

  const RequestRenderer({
    super.key,
    required this.request,
    this.onEdit,
    this.validationResult,
    this.controller,
    this.selectAttribute,
  });

  @override
  State<RequestRenderer> createState() => _RequestRendererState();
}

class _RequestRendererState extends State<RequestRenderer> {
  @override
  void initState() {
    super.initState();

    final items = composeInitialItems(widget.request);
    widget.controller?.value = DecideRequestParameters(
      requestId: widget.request.id,
      items: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> requestItems = [];
    List<StatelessWidget> responseItems = [];

    requestItems = widget.request.items.mapIndexed((index, item) {
      final itemIndex = (rootIndex: index, innerIndex: null);

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(requestItemGroup: item, itemIndex: itemIndex, controller: widget.controller, onEdit: widget.onEdit);
      }

      return RequestItemRenderer(
        item: item,
        itemIndex: itemIndex,
        controller: widget.controller,
        onEdit: widget.onEdit,
        selectAttribute: widget.selectAttribute,
        requestStatus: widget.request.status,
      );
    }).toList();

    if (widget.request.response != null) {
      responseItems = widget.request.response!.content.items.mapIndexed((index, item) {
        final itemIndex = (rootIndex: index, innerIndex: null);

        if (item is ResponseItemGroupDVO) {
          return ResponseItemGroupRenderer(
            responseItemGroup: item,
            requestItems: widget.request.items,
            itemIndex: itemIndex,
            controller: widget.controller,
          );
        }

        return ResponseItemRenderer(
          item: item,
          itemIndex: itemIndex,
          requestItems: widget.request.items,
          controller: widget.controller,
        );
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems.isNotEmpty ? responseItems : requestItems),
    );
  }

  List<DecideRequestParametersItem> composeInitialItems(LocalRequestDVO request) {
    return List<DecideRequestParametersItem>.from(request.items.map((e) {
      if (e is RequestItemGroupDVO) {
        return DecideRequestItemGroupParameters(
          items: List<DecideRequestItemParameters>.from(e.items.map((e) => const RejectRequestItemParameters())),
        );
      }

      return const RejectRequestItemParameters();
    }));
  }
}
