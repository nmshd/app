import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/src/attribute/attribute_renderer.dart';
import '../open_attribute_switcher_function.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/decidable_read_attribute_request_item_renderer.dart';

class ReadAttributeRequestItemRenderer extends StatelessWidget {
  final String currentAddress;
  final ReadAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const ReadAttributeRequestItemRenderer({
    super.key,
    required this.currentAddress,
    required this.item,
    required this.itemIndex,
    this.controller,
    this.openAttributeSwitcher,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: show the help line

    if (item.response != null) {
      return switch (item.response) {
        final ReadAttributeAcceptResponseItemDVO response => AttributeRenderer(
          attribute: response.attribute.content,
          valueHints: response.attribute.valueHints,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
        final AttributeAlreadySharedAcceptResponseItemDVO response => AttributeRenderer(
          attribute: response.attribute.content,
          valueHints: response.attribute.valueHints,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
        final AttributeSuccessionAcceptResponseItemDVO response => AttributeRenderer(
          attribute: response.successor.content,
          valueHints: response.successor.valueHints,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
        // TODO: how to show rejection?
        final RejectResponseItemDVO
        _ =>
          TranslatedText('rejected', style: const TextStyle(color: Colors.red)),
        _ => throw Exception('Unknown response type: ${item.response.runtimeType}'),
      };
    }

    if (item.isDecidable) {
      return DecidableReadAttributeRequestItemRenderer(
        currentAddress: currentAddress,
        item: item,
        itemIndex: itemIndex,
        controller: controller,
        openAttributeSwitcher: openAttributeSwitcher,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
      );
    }

    // TODO: this case should be handled by the renderer above (but disabled)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
