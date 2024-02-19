import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'open_attribute_switcher_function.dart';
import 'request_item_index.dart';
import 'request_item_renderer/request_item_renderer.dart';
import 'request_renderer_controller.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final String currentAddress;
  final RequestItemIndex itemIndex;
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final LocalRequestStatus? requestStatus;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;

  const RequestItemGroupRenderer({
    super.key,
    required this.currentAddress,
    required this.itemIndex,
    required this.requestItemGroup,
    this.controller,
    this.requestStatus,
    this.openAttributeSwitcher,
  });

  @override
  Widget build(BuildContext context) {
    final requestItems = requestItemGroup.items.mapIndexed((index, item) {
      return RequestItemRenderer(
        item: item,
        itemIndex: (rootIndex: itemIndex.rootIndex, innerIndex: index),
        controller: controller,
        requestStatus: requestStatus,
        openAttributeSwitcher: openAttributeSwitcher,
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
