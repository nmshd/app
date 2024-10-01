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

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const RequestItemGroupRenderer({
    super.key,
    required this.currentAddress,
    required this.itemIndex,
    required this.requestItemGroup,
    this.controller,
    this.requestStatus,
    this.openAttributeSwitcher,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
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
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
        backgroundColor: Theme.of(context).colorScheme.surface,
      );
    }).toList();

    return ExpansionTile(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      collapsedBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      maintainState: true,
      initiallyExpanded: true,
      shape: const LinearBorder(side: BorderSide.none),
      // TODO: render anything else than empty string when title is not defined
      title: Text(
        requestItemGroup.title ?? '',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: requestItemGroup.description != null
          ? Text(
              requestItemGroup.description!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            )
          : null,
      iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
      children: requestItems,
    );
  }
}
