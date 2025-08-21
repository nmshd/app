import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../open_attribute_switcher_function.dart';
import '../../request_item_index.dart';
import 'response_item_renderer.dart';

class ResponseItemGroupRenderer extends StatelessWidget {
  final ResponseItemGroupDVO responseItemGroup;
  final RequestItemGroupDVO requestItemGroup;
  final RequestItemIndex itemIndex;
  final OpenAttributeSwitcherFunction openAttributeSwitcher;
  final CreateIdentityAttributeFunction createIdentityAttribute;
  final ComposeRelationshipAttributeFunction composeRelationshipAttribute;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  const ResponseItemGroupRenderer({
    super.key,
    required this.responseItemGroup,
    required this.itemIndex,
    required this.requestItemGroup,
    required this.openAttributeSwitcher,
    required this.createIdentityAttribute,
    required this.composeRelationshipAttribute,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final responseItems = responseItemGroup.items.mapIndexed((index, item) {
      return ResponseItemRenderer(
        responseItem: item,
        requestItem: requestItemGroup.items[index],
        itemIndex: (rootIndex: itemIndex.rootIndex, innerIndex: index),
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
        openAttributeSwitcher: openAttributeSwitcher,
        createIdentityAttribute: createIdentityAttribute,
        composeRelationshipAttribute: composeRelationshipAttribute,
      );
    }).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: responseItems);
  }
}
