import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

import 'open_attribute_switcher_function.dart';
import 'request_item_group_renderer.dart';
import 'request_item_renderer/request_item_renderer.dart';
import 'request_item_renderer/response/response.dart';
import 'request_renderer_controller.dart';

typedef AttributeWithValue = ({IdentityAttributeDVO? attribute, ValueRendererInputValue? value});

class RequestRenderer extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RequestRendererController? controller;
  final String currentAddress;
  final LocalRequestDVO request;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const RequestRenderer({
    super.key,
    required this.formKey,
    required this.request,
    required this.currentAddress,
    this.controller,
    this.openAttributeSwitcher,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
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
            expandFileReference: expandFileReference,
            chooseFile: chooseFile,
            openFileDetails: openFileDetails,
          );
        }

        return ResponseItemRenderer(
          responseItem: item,
          itemIndex: itemIndex,
          requestItem: request.items[index],
          currentAddress: currentAddress,
          expandFileReference: expandFileReference,
          chooseFile: chooseFile,
          openFileDetails: openFileDetails,
        );
      }).toList();

      return Column(children: responseItems);
    }

    final requestItems = request.items.mapIndexed((index, item) {
      final itemIndex = (rootIndex: index, innerIndex: null);

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(
          requestItemGroup: item,
          itemIndex: itemIndex,
          controller: controller,
          requestStatus: request.status,
          openAttributeSwitcher: openAttributeSwitcher,
          currentAddress: currentAddress,
          expandFileReference: expandFileReference,
          chooseFile: chooseFile,
          openFileDetails: openFileDetails,
        );
      }

      return RequestItemRenderer(
        item: item,
        itemIndex: itemIndex,
        controller: controller,
        openAttributeSwitcher: openAttributeSwitcher,
        requestStatus: request.status,
        currentAddress: currentAddress,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
      );
    }).toList();

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(children: requestItems),
    );
  }
}
