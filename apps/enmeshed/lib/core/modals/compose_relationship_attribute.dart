import 'dart:async';
import 'dart:math';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';

import '../types/types.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

Future<RelationshipAttribute?> showComposeRelationshipAttributeModal({
  required BuildContext context,
  required String accountId,
  required ProcessedRelationshipAttributeQueryDVO query,
}) async {
  final attribute = await showModalBottomSheet<RelationshipAttribute>(
    context: context,
    isScrollControlled: true,
    builder: (builder) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      child: _ComposeRelationshipAttributeModal(
        accountId: accountId,
        query: query,
      ),
    ),
  );

  return attribute;
}

class _ComposeRelationshipAttributeModal extends StatefulWidget {
  final String accountId;
  final ProcessedRelationshipAttributeQueryDVO query;

  const _ComposeRelationshipAttributeModal({required this.accountId, required this.query});

  @override
  State<_ComposeRelationshipAttributeModal> createState() => _ComposeRelationshipAttributeModalState();
}

class _ComposeRelationshipAttributeModalState extends State<_ComposeRelationshipAttributeModal> {
  final _controller = ValueRendererController();
  final _scrollController = ScrollController();

  late RelationshipAttribute? _relationshipAttribute;
  bool _confirmEnabled = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final value = _controller.value;

      if (value is ValueRendererValidationError) {
        setState(() => _confirmEnabled = false);
        return;
      }

      final canCreateAttribute = composeRelationshipAttributeValue(
        isComplex: widget.query.renderHints.editType == RenderHintsEditType.Complex,
        currentAddress: '',
        valueType: widget.query.attributeCreationHints.valueType,
        query: widget.query,
        inputValue: value as ValueRendererInputValue,
      );

      if (canCreateAttribute != null) {
        _relationshipAttribute = canCreateAttribute;
        setState(() => _confirmEnabled = true);
      } else {
        setState(() => _confirmEnabled = false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: max(MediaQuery.viewInsetsOf(context).bottom, MediaQuery.viewPaddingOf(context).bottom)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.myData_createAttribute_title(widget.query.attributeCreationHints.title)),
          Flexible(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueRenderer(
                      renderHints: widget.query.renderHints,
                      valueHints: widget.query.valueHints,
                      controller: _controller,
                      valueType: widget.query.attributeCreationHints.valueType,
                      expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                      chooseFile: () => openFileChooser(context: context, accountId: widget.accountId),
                      openFileDetails: (file) =>
                          context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: createFileRecord(file: file)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: context.pop, child: Text(context.l10n.cancel)),
                FilledButton(onPressed: !_confirmEnabled ? null : () => context.pop(_relationshipAttribute), child: Text(context.l10n.save)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
