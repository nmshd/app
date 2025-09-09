import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'open_attribute_switcher_function.dart';
import 'request_item_group_renderer.dart';
import 'request_item_renderer/request_item_renderer.dart';
import 'request_renderer_controller.dart';

class RequestRenderer extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RequestRendererController? controller;
  final LocalRequestDVO request;
  final OpenAttributeSwitcherFunction openAttributeSwitcher;
  final CreateIdentityAttributeFunction createIdentityAttribute;
  final ComposeRelationshipAttributeFunction composeRelationshipAttribute;

  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  final RequestValidationResultDTO? validationResult;

  const RequestRenderer({
    required this.formKey,
    required this.request,
    required this.controller,
    required this.openAttributeSwitcher,
    required this.createIdentityAttribute,
    required this.composeRelationshipAttribute,
    required this.expandFileReference,
    required this.openFileDetails,
    required this.validationResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final requestItems = request.items.mapIndexed((index, item) {
      final itemIndex = (rootIndex: index, innerIndex: null);

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(
          requestItemGroup: item,
          itemIndex: itemIndex,
          controller: controller,
          requestStatus: request.status,
          openAttributeSwitcher: openAttributeSwitcher,
          createIdentityAttribute: createIdentityAttribute,
          composeRelationshipAttribute: composeRelationshipAttribute,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
          validationResult: validationResult?.items[index],
        );
      }

      return RequestItemRenderer(
        item: item,
        itemIndex: itemIndex,
        controller: controller,
        openAttributeSwitcher: openAttributeSwitcher,
        createIdentityAttribute: createIdentityAttribute,
        composeRelationshipAttribute: composeRelationshipAttribute,
        requestStatus: request.status,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
        validationResult: validationResult?.items[index],
        backgroundColor: null,
      );
    }).toList();

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(children: requestItems),
    );
  }
}
