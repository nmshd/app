import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/request_renderer_controller.dart';
import 'renderers/request_item_group_renderer.dart';
import 'renderers/request_item_renderer/request_item_renderer.dart';
import 'renderers/request_item_renderer/response/response.dart';

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO request;
  final VoidCallback? onEdit;
  final RequestValidationResultDTO? validationResult;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;

  const RequestRenderer({
    super.key,
    required this.request,
    this.onEdit,
    this.validationResult,
    this.controller,
    this.selectAttribute,
  });

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> requestItems = [];
    List<StatelessWidget> responseItems = [];

    requestItems = request.items.mapIndexed((index, item) {
      final itemIndex = (rootIndex: index, innerIndex: null);

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(
          requestItemGroup: item,
          itemIndex: itemIndex,
          controller: controller,
          onEdit: onEdit,
          requestStatus: request.status,
          selectAttribute: selectAttribute,
        );
      }

      return RequestItemRenderer(
        item: item,
        itemIndex: itemIndex,
        controller: controller,
        onEdit: onEdit,
        selectAttribute: selectAttribute,
        requestStatus: request.status,
      );
    }).toList();

    if (request.response != null) {
      responseItems = request.response!.content.items.mapIndexed((index, item) {
        final itemIndex = (rootIndex: index, innerIndex: null);

        if (item is ResponseItemGroupDVO) {
          final requestItemGroup = request.items[index] as RequestItemGroupDVO;
          return ResponseItemGroupRenderer(
            responseItemGroup: item,
            requestItemGroup: requestItemGroup,
            itemIndex: itemIndex,
            controller: controller,
          );
        }

        return ResponseItemRenderer(
          responseItem: item,
          itemIndex: itemIndex,
          requestItem: request.items[index],
          controller: controller,
        );
      }).toList();
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems.isNotEmpty ? responseItems : requestItems),
    );
  }
}
