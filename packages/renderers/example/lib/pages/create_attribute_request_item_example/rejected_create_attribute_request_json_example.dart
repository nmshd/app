import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(localRequestDVO.name),
                const SizedBox(height: 8),
                if (localRequestDVO.description != null) ...[
                  const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                  TranslatedText(localRequestDVO.description!),
                  const SizedBox(height: 8),
                ],
                const Text('Request ID:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(localRequestDVO.id),
                const SizedBox(height: 8),
                const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(localRequestDVO.status.name),
                const SizedBox(height: 8),
                const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(localRequestDVO.createdBy.name),
                const SizedBox(height: 8),
                const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(localRequestDVO.createdAt))),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: RequestRenderer(
              request: localRequestDVO,
              currentAddress: 'a currentAddress',
              chooseFile: () async => null,
              expandFileReference: (_) async => throw Exception('Not implemented'),
              openFileDetails: (_) async => throw Exception('Not implemented'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadJsonData() async {
    final jsonData = await rootBundle.loadString('assets/RejectedCreateAttributeRequest.json');

    setState(() => jsonExample = jsonDecode(jsonData));
  }
}
