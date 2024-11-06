import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

import 'request_item_index.dart';
import 'request_item_renderer/request_item_renderer.dart';

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
  final Future<AttributeWithValue?> Function(String) openCreateAttribute;

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
    required this.openCreateAttribute,
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
        openCreateAttribute: openCreateAttribute,
      );
    }).toList();

    final title = requestItemGroup.title != null
        ? Text(requestItemGroup.title ?? '', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface))
        : null;

    final subtitle = requestItemGroup.description != null
        ? Text(
            requestItemGroup.description!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          )
        : null;

    return ExpansionTile(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      collapsedBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      maintainState: true,
      initiallyExpanded: true,
      shape: const LinearBorder(side: BorderSide.none),
      title: title ?? subtitle ?? const Text(''),
      subtitle: title != null ? subtitle : null,
      iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
      children: requestItems,
    );
  }
}
