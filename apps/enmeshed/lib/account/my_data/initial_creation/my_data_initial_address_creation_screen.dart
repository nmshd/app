import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'my_data_initial_creation_screen.dart';

class MyDataInitialAddressCreationScreen extends StatefulWidget {
  final String accountId;

  const MyDataInitialAddressCreationScreen({required this.accountId, super.key});

  @override
  State<MyDataInitialAddressCreationScreen> createState() => _MyDataInitialAddressCreationScreenState();
}

class _MyDataInitialAddressCreationScreenState extends State<MyDataInitialAddressCreationScreen> {
  String? _valueType;

  @override
  Widget build(BuildContext context) {
    if (_valueType == null) return _SelectAddressTypeView(selectType: _selectType);

    final translatedAttribute = FlutterI18n.translate(context, 'dvo.attribute.name.$_valueType');

    return MyDataInitialCreationScreen(
      valueTypes: [_valueType!],
      accountId: widget.accountId,
      resetType: _selectType,
      onAttributesCreated: () => context.go('/account/${widget.accountId}/my-data/address-data'),
      title: context.l10n.myData_initialCreation_addressData_createAttribute_title(translatedAttribute),
      description: context.l10n.myData_initialCreation_addressData_createAttribute_description(translatedAttribute),
    );
  }

  void _selectType([String? value]) {
    setState(() => _valueType = value);
  }
}

class _SelectAddressTypeView extends StatelessWidget {
  final void Function(String) selectType;

  const _SelectAddressTypeView({required this.selectType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.myData_initialCreation_addressData_title)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(context.l10n.myData_initialCreation_addressData_description),
            ),
            Gaps.h16,
            ColoredBox(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  ListTile(
                    title: Text(context.l10n.myData_initialCreation_addressData_streetAddress, style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(context.l10n.myData_initialCreation_addressData_streetAddress_description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => selectType('StreetAddress'),
                  ),
                  const Divider(indent: 16),
                  ListTile(
                    title: Text(context.l10n.myData_initialCreation_addressData_deliveryBoxAddress, style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(context.l10n.myData_initialCreation_addressData_deliveryBoxAddress_description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => selectType('DeliveryBoxAddress'),
                  ),
                  const Divider(indent: 16),
                  ListTile(
                    title: Text(context.l10n.myData_initialCreation_addressData_postOfficeBoxAddress, style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(context.l10n.myData_initialCreation_addressData_postOfficeBoxAddress_description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => selectType('PostOfficeBoxAddress'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
