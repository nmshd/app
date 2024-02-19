import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'request_item_group_renderer.dart';
import 'request_item_renderer/request_item_renderer.dart';
import 'request_item_renderer/response/response.dart';
import 'request_item_renderer/widgets/open_attribute_screen_function.dart';
import 'request_renderer_controller.dart';

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final String currentAddress;
  final LocalRequestDVO request;
  final RequestValidationResultDTO? validationResult;
  final OpenAttributeScreenFunction? openAttributeScreen;

  const RequestRenderer({
    super.key,
    required this.request,
    required this.currentAddress,
    this.validationResult,
    this.controller,
    this.openAttributeScreen,
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
            currentAddress: currentAddress,
          );
        }

        return ResponseItemRenderer(
          responseItem: item,
          itemIndex: itemIndex,
          requestItem: request.items[index],
          currentAddress: currentAddress,
        );
      }).toList();

      return ListView(children: responseItems);
    }

    final requestItems = request.items.mapIndexed((index, item) {
      final itemIndex = (rootIndex: index, innerIndex: null);

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(
          requestItemGroup: item,
          itemIndex: itemIndex,
          controller: controller,
          requestStatus: request.status,
          openAttributeScreen: openAttributeScreen,
          currentAddress: currentAddress,
        );
      }

      return RequestItemRenderer(
        item: item,
        itemIndex: itemIndex,
        controller: controller,
        openAttributeScreen: openAttributeScreen,
        requestStatus: request.status,
        currentAddress: currentAddress,
      );
    }).toList();

    return ListView(children: requestItems);
  }
}
