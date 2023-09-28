import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:renderers/renderers.dart';

class ItemExamples2 extends StatefulWidget {
  const ItemExamples2({super.key});

  @override
  State<ItemExamples2> createState() => _ItemExamples2State();
}

class _ItemExamples2State extends State<ItemExamples2> {
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
    final jsonData = await rootBundle.loadString('assets/RejectedCreateAttributeRequest.json');

    setState(() => jsonExample = jsonDecode(jsonData));
  }
}
