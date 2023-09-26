import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:renderers/renderers.dart';

class ItemGroupExample extends StatefulWidget {
  const ItemGroupExample({super.key});

  @override
  State<ItemGroupExample> createState() => _ItemGroupExampleState();
}

class _ItemGroupExampleState extends State<ItemGroupExample> {
  Map<String, dynamic>? jsonExample;

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (jsonExample == null) return const CircularProgressIndicator();
    final localRequestDVO = LocalRequestDVO.fromJson(jsonExample!);
    return RequestRenderer(request: localRequestDVO);
  }

  Future<void> loadJsonData() async {
    final jsonData = await rootBundle.loadString('assets/request_example_group.json');

    setState(() {
      jsonExample = jsonDecode(jsonData);
    });
  }
}
