import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';

import '/core/core.dart';

class MyDataInitialCreationScreen extends StatefulWidget {
  final String accountId;
  final List<String> valueTypes;
  final VoidCallback onAttributesCreated;
  final String title;
  final String description;
  final VoidCallback? resetType;

  const MyDataInitialCreationScreen({
    required this.accountId,
    required this.valueTypes,
    required this.onAttributesCreated,
    required this.title,
    required this.description,
    this.resetType,
    super.key,
  });

  @override
  State<MyDataInitialCreationScreen> createState() => _MyDataInitialCreationScreenState();
}

class _MyDataInitialCreationScreenState extends State<MyDataInitialCreationScreen> {
  final _controllers = <String, ValueRendererController>{};
  final _hintResponses = <String, GetHintsResponse>{};
  final _attributeValues = <String, IdentityAttribute?>{};
  final _valueRendererValidationErrors = <String>[];

  bool _saveEnabled = false;
  bool _isLoading = false;
  bool _controllersInitialized = false;
  bool _rendererHintsLoaded = false;

  @override
  void initState() {
    super.initState();

    _setupControllers();
    _loadRenderHints();
  }

  @override
  void dispose() {
    for (final controller in _controllers.entries) {
      controller.value.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title, maxLines: 2),
      leading: BackButton(onPressed: widget.resetType ?? () => context.pop()),
    );

    if (!_controllersInitialized || !_rendererHintsLoaded) {
      return Scaffold(appBar: appBar, body: const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.description, style: Theme.of(context).textTheme.bodyMedium),
                  if (addressDataInitialAttributeTypes.any(widget.valueTypes.contains)) ...[
                    Gaps.h16,
                    Text(context.l10n.mandatoryField, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ],
              ),
            ),
            Gaps.h24,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.valueTypes.length,
              separatorBuilder: (context, index) => Gaps.h16,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ValueRenderer(
                        fieldName: addressDataInitialAttributeTypes.contains(widget.valueTypes[index])
                            ? null
                            : 'i18n://dvo.attribute.name.${widget.valueTypes[index]}',
                        renderHints: _hintResponses[widget.valueTypes[index]]!.renderHints,
                        valueHints: _hintResponses[widget.valueTypes[index]]!.valueHints,
                        controller: _controllers[widget.valueTypes[index]],
                        valueType: widget.valueTypes[index],
                        decoration: widget.valueTypes[index] == 'BirthDate' ||
                                _hintResponses[widget.valueTypes[index]]!.renderHints.editType != RenderHintsEditType.Complex
                            ? InputDecoration(
                                counterText: '',
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                hintMaxLines: 150,
                                errorMaxLines: 150,
                                helperMaxLines: 150,
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                                ),
                              )
                            : null,
                        expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                        chooseFile: () => openFileChooser(context: context, accountId: widget.accountId),
                        openFileDetails: (file) => context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: file),
                      ),
                      _getExplanationForAttribute(widget.valueTypes[index], context),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: _isLoading ? null : widget.resetType ?? () => context.pop(), child: Text(context.l10n.cancel)),
                Gaps.w4,
                FilledButton(
                  onPressed: _saveEnabled && !_isLoading ? _createAttributes : null,
                  child: Text(context.l10n.save),
                ),
                Gaps.w16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setupControllers() {
    for (final valueType in widget.valueTypes) {
      _controllers[valueType] = ValueRendererController();

      _controllers[valueType]!.addListener(
        () {
          final value = _controllers[valueType]!.value;

          if (value is ValueRendererValidationError) {
            if (!_valueRendererValidationErrors.contains(valueType)) _valueRendererValidationErrors.add(valueType);

            _attributeValues.remove(valueType);
          } else if (value is ValueRendererInputValueString && value.value.isEmpty) {
            _valueRendererValidationErrors.remove(valueType);
            _attributeValues.remove(valueType);
          } else {
            _attributeValues[valueType] = composeIdentityAttributeValue(
              isComplex: _hintResponses[valueType]?.renderHints.editType == RenderHintsEditType.Complex,
              currentAddress: widget.accountId,
              valueType: valueType,
              inputValue: value as ValueRendererInputValue,
            );
            _valueRendererValidationErrors.remove(valueType);
          }

          _updateSaveEnabled();
        },
      );
    }

    if (mounted) setState(() => _controllersInitialized = true);
  }

  Future<void> _loadRenderHints() async {
    for (final valueType in widget.valueTypes) {
      final result = await GetIt.I.get<EnmeshedRuntime>().getHints(valueType);
      _hintResponses[valueType] = result.value;
    }

    //some custom adaptations are needed:
    if (_hintResponses.containsKey('Sex')) {
      _hintResponses['Sex'] = GetHintsResponse(
        valueHints: _hintResponses['Sex']!.valueHints,
        renderHints: RenderHints(
          editType: RenderHintsEditType.SelectLike,
          technicalType: RenderHintsTechnicalType.String,
        ),
      );
    }
    if (mounted) setState(() => _rendererHintsLoaded = true);
  }

  Widget _getExplanationForAttribute(String attributeType, BuildContext context) {
    switch (attributeType) {
      case 'Citizenship':
        return _InfoText(context.l10n.myData_initialCreation_personalData_infoCitizenship);
      case 'Sex':
        return _InfoText(context.l10n.myData_initialCreation_personalData_infoGender);
      case 'PhoneNumber':
        return _InfoText(context.l10n.myData_initialCreation_communicationData_infoPhoneNumber);
      case 'Website':
        return _InfoText(context.l10n.myData_initialCreation_communicationData_infoWebsite);
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _createAttributes() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _saveEnabled = false;
      });
    }

    for (final attributeValue in _attributeValues.entries) {
      final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

      final createAttributeResult = await session.consumptionServices.attributes.createRepositoryAttribute(
        value: attributeValue.value!.value,
      );

      if (createAttributeResult.isError) {
        GetIt.I.get<Logger>().e(createAttributeResult.error.message);

        if (mounted) {
          showErrorSnackbar(context: context, text: context.l10n.myData_initialCreation_error);
          context.pop();
        }
        return;
      }
    }
    widget.onAttributesCreated();
  }

  void _updateSaveEnabled() {
    if (_attributeValues.isNotEmpty && _valueRendererValidationErrors.isEmpty) {
      if (mounted) setState(() => _saveEnabled = true);
    } else {
      if (mounted) setState(() => _saveEnabled = false);
    }
  }
}

class _InfoText extends StatelessWidget {
  final String text;

  const _InfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
