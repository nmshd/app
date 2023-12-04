import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'renderers/request_item_group_renderer.dart';
import 'renderers/request_item_renderer/request_item_renderer.dart';
import 'renderers/request_item_renderer/response/response.dart';
import 'renderers/widgets/request_renderer_controller.dart';

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO request;
  final RequestValidationResultDTO? validationResult;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;

  const RequestRenderer({
    super.key,
    required this.request,
    this.validationResult,
    this.controller,
    this.selectAttribute,
  });

  @override
  Widget build(BuildContext context) {
    if (request.response != null) {
      final responseItems = request.response!.content.items.mapIndexed((index, item) {
        final itemIndex = (rootIndex: index, innerIndex: null);

        if (item is ResponseItemGroupDVO) {
          final requestItemGroup = request.items[index] as RequestItemGroupDVO;
          return ResponseItemGroupRenderer(
            responseItemGroup: item,
            requestItemGroup: requestItemGroup,
            itemIndex: itemIndex,
          );
        }

        return ResponseItemRenderer(
          responseItem: item,
          itemIndex: itemIndex,
          requestItem: request.items[index],
        );
      }).toList();

      return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems),
      );
    }

    final requestItems = request.items.mapIndexed((index, item) {
      final itemIndex = (rootIndex: index, innerIndex: null);

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(
          requestItemGroup: item,
          itemIndex: itemIndex,
          controller: controller,
          requestStatus: request.status,
          selectAttribute: selectAttribute,
        );
      }

      return RequestItemRenderer(
        item: item,
        itemIndex: itemIndex,
        controller: controller,
        selectAttribute: selectAttribute,
        requestStatus: request.status,
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: requestItems),
    );
  }
}
