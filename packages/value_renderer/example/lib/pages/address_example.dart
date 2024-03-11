import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:value_renderer/value_renderer.dart';

class AddressExample extends StatefulWidget {
  const AddressExample({super.key});

  @override
  State<AddressExample> createState() => _AddressExampleState();
}

class _AddressExampleState extends State<AddressExample> {
  ValueHints? _streetAddressValueHints;
  ValueHints? _deliveryBoxAddressValueHints;
  ValueHints? _postOfficeBoxAddressValueHints;

  RenderHints? _streetAddressRenderHints;
  RenderHints? _deliveryBoxAddressRenderHints;
  RenderHints? _postOfficeBoxAddressRenderHints;

  @override
  void initState() {
    _loadJsonData();

    super.initState();
  }

  Future<void> _loadJsonData() async {
    final streetAddressValueHintsJsonData = await rootBundle.loadString('assets/streetAddressValueHints.json');
    final deliveryBoxAddressValueHintsJsonData = await rootBundle.loadString('assets/deliveryBoxAddressValueHints.json');
    final postOfficeBoxAddressValueHintsJsonData = await rootBundle.loadString('assets/postOfficeBoxAddressValueHints.json');

    final streetAddressRenderHintsJsonData = await rootBundle.loadString('assets/streetAddressRenderHints.json');
    final deliveryBoxAddressRenderHintsJsonData = await rootBundle.loadString('assets/deliveryBoxAddressRenderHints.json');
    final postOfficeBoxAddressRenderHintsJsonData = await rootBundle.loadString('assets/postOfficeBoxAddressRenderHints.json');

    setState(() {
      _streetAddressValueHints = ValueHints.fromJson(jsonDecode(streetAddressValueHintsJsonData));
      _deliveryBoxAddressValueHints = ValueHints.fromJson(jsonDecode(deliveryBoxAddressValueHintsJsonData));
      _postOfficeBoxAddressValueHints = ValueHints.fromJson(jsonDecode(postOfficeBoxAddressValueHintsJsonData));

      _streetAddressRenderHints = RenderHints.fromJson(jsonDecode(streetAddressRenderHintsJsonData));
      _deliveryBoxAddressRenderHints = RenderHints.fromJson(jsonDecode(deliveryBoxAddressRenderHintsJsonData));
      _postOfficeBoxAddressRenderHints = RenderHints.fromJson(jsonDecode(postOfficeBoxAddressRenderHintsJsonData));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_addressHintsExist) return const CircularProgressIndicator();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Street Address Example', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ValueRenderer(
                  chooseFile: () async => null,
                  expandFileReference: (_) async => throw Exception('Not implemented'),
                  openFileDetails: (_) {},
                  renderHints: _streetAddressRenderHints!,
                  valueHints: _streetAddressValueHints!,
                  valueType: 'StreetAddress',
                ),
                const SizedBox(height: 16),
                const Text('Delivery Box Address Example', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ValueRenderer(
                  chooseFile: () async => null,
                  expandFileReference: (_) async => throw Exception('Not implemented'),
                  openFileDetails: (_) {},
                  renderHints: _deliveryBoxAddressRenderHints!,
                  valueHints: _deliveryBoxAddressValueHints!,
                  valueType: 'DeliveryBoxAddress',
                ),
                const SizedBox(height: 16),
                const Text('Post Office Box Address Example', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ValueRenderer(
                  chooseFile: () async => null,
                  expandFileReference: (_) async => throw Exception('Not implemented'),
                  openFileDetails: (_) {},
                  renderHints: _postOfficeBoxAddressRenderHints!,
                  valueHints: _postOfficeBoxAddressValueHints!,
                  valueType: 'PostOfficeBoxAddress',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get _addressHintsExist =>
      _streetAddressValueHints != null ||
      _deliveryBoxAddressValueHints != null ||
      _postOfficeBoxAddressValueHints != null ||
      _streetAddressRenderHints != null ||
      _deliveryBoxAddressRenderHints != null ||
      _postOfficeBoxAddressRenderHints != null;
}
