import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:renderers/renderers.dart';

class RejectedCreateAttributeRequestJsonExample extends StatefulWidget {
  const RejectedCreateAttributeRequestJsonExample({super.key});

  @override
  State<RejectedCreateAttributeRequestJsonExample> createState() => _RejectedCreateAttributeRequestJsonExampleState();
}

class _RejectedCreateAttributeRequestJsonExampleState extends State<RejectedCreateAttributeRequestJsonExample> {
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: RequestRenderer(request: localRequestDVO),
    );
  }

  Future<void> loadJsonData() async {
    final jsonData = await rootBundle.loadString('assets/RejectedCreateAttributeRequest.json');

    setState(() => jsonExample = jsonDecode(jsonData));
  }
}
