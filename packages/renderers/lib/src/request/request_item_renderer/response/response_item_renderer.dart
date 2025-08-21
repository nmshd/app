import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '/src/attribute/attribute_renderer.dart';
import '../../open_attribute_switcher_function.dart';
import '../../request_item_index.dart';
import '../request_item_renderer.dart';
import 'error_response_item_renderer.dart';
import 'response.dart';

class ResponseItemRenderer extends StatelessWidget {
  final ResponseItemDVO responseItem;
  final RequestItemDVO requestItem;
  final RequestItemIndex itemIndex;
  final OpenAttributeSwitcherFunction openAttributeSwitcher;
  final CreateIdentityAttributeFunction createIdentityAttribute;
  final ComposeRelationshipAttributeFunction composeRelationshipAttribute;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  const ResponseItemRenderer({
    super.key,
    required this.itemIndex,
    required this.responseItem,
    required this.requestItem,
    required this.openAttributeSwitcher,
    required this.createIdentityAttribute,
    required this.composeRelationshipAttribute,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (requestItem is! ProposeAttributeRequestItemDVO) {
      return RequestItemRenderer(
        item: requestItem,
        itemIndex: itemIndex,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
        openAttributeSwitcher: openAttributeSwitcher,
        createIdentityAttribute: createIdentityAttribute,
        composeRelationshipAttribute: composeRelationshipAttribute,
        controller: null,
        requestStatus: null,
        backgroundColor: null,
        validationResult: null,
      );
    }

    final widget = switch (responseItem) {
      final AttributeAlreadySharedAcceptResponseItemDVO dvo => AttributeRenderer(
        attribute: dvo.attribute.content,
        valueHints: dvo.attribute.valueHints,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final AttributeSuccessionAcceptResponseItemDVO dvo => AttributeRenderer(
        attribute: dvo.successor.content,
        valueHints: dvo.successor.valueHints,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final ProposeAttributeAcceptResponseItemDVO dvo => ProposeAttributeAcceptResponseItemRenderer(
        item: dvo,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final ErrorResponseItemDVO dvo => ErrorResponseItemRenderer(item: dvo),
      final RejectResponseItemDVO _ || final AcceptResponseItemDVO _ => RequestItemRenderer(
        item: requestItem,
        itemIndex: itemIndex,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
        openAttributeSwitcher: openAttributeSwitcher,
        createIdentityAttribute: createIdentityAttribute,
        composeRelationshipAttribute: composeRelationshipAttribute,
        controller: null,
        requestStatus: null,
        backgroundColor: null,
        validationResult: null,
      ),
      _ => throw Exception("Invalid type '${responseItem.type}'"),
    };

    if (widget is RequestItemRenderer) return widget;
    return Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: widget);
  }
}
