import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';

Future<void> showCreateAttributeModal({
  required BuildContext context,
  required String accountId,
  required void Function({required BuildContext context, required IdentityAttributeValue value})? onCreateAttributePressed,
  required VoidCallback? onAttributeCreated,
  String? initialValueType,
}) async {
  assert(
    (onCreateAttributePressed != null && onAttributeCreated == null) || (onCreateAttributePressed == null && onAttributeCreated != null),
    'Either onCreateAttributePressed or onAttributeCreated must be provided',
  );

  final controller = ValueRendererController();
  final createEnabledNotifier = ValueNotifier<bool>(false);
  final valueTypeNotifier = ValueNotifier<String?>(null);
  final pageIndexNotifier = ValueNotifier<int>(0);

  IdentityAttributeValue? identityAttribute;
  late RenderHints renderHints;
  late ValueHints valueHints;

  if (initialValueType != null) {
    valueTypeNotifier.value = initialValueType;

    final hintsResult = await GetIt.I.get<EnmeshedRuntime>().getHints(initialValueType);
    final hints = hintsResult.value;
    renderHints = hints.renderHints;
    valueHints = hints.valueHints;

    pageIndexNotifier.value++;
  }

  controller.addListener(() {
    final value = controller.value;

    if (valueTypeNotifier.value == null) return;

    if (value is ValueRendererValidationError) {
      createEnabledNotifier.value = false;
      return;
    }

    final canCreateAttribute = composeIdentityAttributeValue(
      isComplex: renderHints.editType == RenderHintsEditType.Complex,
      currentAddress: '',
      valueType: valueTypeNotifier.value,
      inputValue: value as ValueRendererInputValue,
    );

    if (canCreateAttribute != null) {
      identityAttribute = canCreateAttribute.value;
      createEnabledNotifier.value = true;
    } else {
      createEnabledNotifier.value = false;
    }
  });

  final closeButton = Padding(
    padding: const EdgeInsets.only(right: 8),
    child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
  );

  if (!context.mounted) return;

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    pageIndexNotifier: pageIndexNotifier,
    onModalDismissedWithBarrierTap: () => context.pop(),
    showDragHandle: false,
    pageListBuilder: (context) => [
      WoltModalSheetPage(
        trailingNavBarWidget: closeButton,
        leadingNavBarWidget: Padding(
          padding: const EdgeInsets.only(left: 16, top: 20),
          child: Text(context.l10n.myData_createInformation, style: Theme.of(context).textTheme.headlineSmall),
        ),
        isTopBarLayerAlwaysVisible: false,
        child: _EditableAttributes(
          accountId: accountId,
          goToNextPage: (valueType) async {
            final hintsResult = await GetIt.I.get<EnmeshedRuntime>().getHints(valueType);
            valueTypeNotifier.value = valueType;

            if (hintsResult.isSuccess) {
              final hints = hintsResult.value;
              renderHints = hints.renderHints;
              valueHints = hints.valueHints;

              pageIndexNotifier.value++;
              return;
            }

            GetIt.I.get<Logger>().e('Getting attribute hints failed caused by: ${hintsResult.error}');

            if (context.mounted) {
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
                    content: Text(context.l10n.errorDialog_description),
                  );
                },
              );
            }
          },
        ),
      ),
      WoltModalSheetPage(
        trailingNavBarWidget: closeButton,
        stickyActionBar: ValueListenableBuilder<bool>(
          valueListenable: createEnabledNotifier,
          builder: (context, enabled, child) {
            return Padding(
              padding: EdgeInsets.only(right: MediaQuery.viewInsetsOf(context).right + 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                  Gaps.w8,
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: !enabled
                        ? null
                        : () => onAttributeCreated != null
                            ? createRepositoryAttribute(
                                accountId: accountId,
                                context: context,
                                createEnabledNotifier: createEnabledNotifier,
                                value: identityAttribute!,
                                onAttributeCreated: onAttributeCreated,
                              )
                            : onCreateAttributePressed!(context: context, value: identityAttribute!),
                    child: Text(context.l10n.save),
                  ),
                ],
              ),
            );
          },
        ),
        leadingNavBarWidget: ValueListenableBuilder<String?>(
          valueListenable: valueTypeNotifier,
          builder: (context, valueType, child) {
            final translatedAttribute = FlutterI18n.translate(context, 'dvo.attribute.name.$valueType');

            return Padding(
              padding: initialValueType == null ? EdgeInsets.zero : const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  if (initialValueType == null)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => pageIndexNotifier.value = 0,
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
                    child: valueType == null
                        ? Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge)
                        : Text(context.l10n.myData_createAttribute_title(translatedAttribute), style: Theme.of(context).textTheme.titleSmall),
                  ),
                ],
              ),
            );
          },
        ),
        child: ValueListenableBuilder<String?>(
          valueListenable: valueTypeNotifier,
          builder: (context, valueType, child) {
            if (valueType == null) {
              return Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 80),
                child: Text(context.l10n.errorDialog_description),
              );
            }

            return Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (addressDataInitialAttributeTypes.contains(valueType)) ...[
                    Text(context.l10n.mandatoryField, style: Theme.of(context).textTheme.bodyMedium),
                    Gaps.h24,
                  ],
                  ValueRenderer(
                    renderHints: renderHints,
                    valueHints: valueHints,
                    controller: controller,
                    valueType: valueType,
                    expandFileReference: (fileReference) => expandFileReference(accountId: accountId, fileReference: fileReference),
                    chooseFile: () => openFileChooser(context, accountId),
                    openFileDetails: (file) => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );

  controller.dispose();
  createEnabledNotifier.dispose();
  valueTypeNotifier.dispose();
  pageIndexNotifier.dispose();
}

class _EditableAttributes extends StatefulWidget {
  final void Function(String valueType) goToNextPage;
  final String accountId;

  const _EditableAttributes({required this.accountId, required this.goToNextPage});

  @override
  State<_EditableAttributes> createState() => _EditableAttributesState();
}

class _EditableAttributesState extends State<_EditableAttributes> {
  List<({String key, String translation})>? _editableAttributes;

  @override
  void initState() {
    super.initState();

    _loadEditableAttributes();
  }

  @override
  Widget build(BuildContext context) {
    if (_editableAttributes == null) {
      return Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_editableAttributes!.isEmpty) {
      return EmptyListIndicator(icon: Icons.co_present_outlined, text: context.l10n.no_data_available, wrapInListView: true);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(context.l10n.myData_chooseInformationType),
        ),
        Gaps.h16,
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _editableAttributes!.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_editableAttributes![index].translation),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => widget.goToNextPage(_editableAttributes![index].key),
          ),
          separatorBuilder: (context, index) => const Divider(height: 0, indent: 16),
        ),
        SizedBox(height: MediaQuery.viewInsetsOf(context).bottom + 24),
      ],
    );
  }

  Future<void> _loadEditableAttributes({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncDatawallet();

    final editableAttributes = await GetIt.I.get<EnmeshedRuntime>().getEditableAttributes();

    editableAttributes
      ..remove('SchematizedXML')
      ..remove('Affiliation');

    ({String key, String translation}) translate(String s) => (key: s, translation: context.i18nTranslate('i18n://dvo.attribute.name.$s'));

    final translated = editableAttributes.map(translate).toList()..sort((a, b) => a.translation.compareTo(b.translation));
    if (mounted) setState(() => _editableAttributes = translated);
  }
}
