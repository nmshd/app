import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'request_item_renderer/request_item_renderer.dart';
import 'widgets/request_item_index.dart';
import 'widgets/request_renderer_controller.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;
  final String currentAddress;

  const RequestItemGroupRenderer({
    super.key,
    required this.requestItemGroup,
    this.controller,
    required this.itemIndex,
    this.requestStatus,
    this.selectAttribute,
    required this.currentAddress,
  });

  @override
  Widget build(BuildContext context) {
    final requestItems = requestItemGroup.items.mapIndexed((index, item) {
      return RequestItemRenderer(
        item: item,
        itemIndex: (rootIndex: itemIndex.rootIndex, innerIndex: index),
        controller: controller,
        requestStatus: requestStatus,
        selectAttribute: selectAttribute,
        currentAddress: currentAddress,
      );
    }).toList();

    return ExpansionTile(
      maintainState: true,
      initiallyExpanded: true,
      // TODO: render anything else than empty string when title is not defined
      title: Text(requestItemGroup.title ?? ''),
      subtitle: requestItemGroup.description != null ? Text(requestItemGroup.description!) : null,
      children: requestItems,
    );
  }
}
