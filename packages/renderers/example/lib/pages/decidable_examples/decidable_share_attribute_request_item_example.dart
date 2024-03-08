import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class DecidableShareAttributeRequestItemExample extends StatefulWidget {
  const DecidableShareAttributeRequestItemExample({super.key});

  @override
  State<DecidableShareAttributeRequestItemExample> createState() => _DecidableShareAttributeRequestItemExampleState();
}

class _DecidableShareAttributeRequestItemExampleState extends State<DecidableShareAttributeRequestItemExample> {
  Map<String, dynamic>? jsonExample;

  @override
  void initState() {
    _loadJsonData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (jsonExample == null) return const CircularProgressIndicator();
    final localRequestDVO = LocalRequestDVO.fromJson(jsonExample!);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            TranslatedText(localRequestDVO.statusText),
            const SizedBox(height: 8),
            const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(localRequestDVO.createdBy.name),
            const SizedBox(height: 8),
            const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(localRequestDVO.createdAt))),
            const Divider(),
            Expanded(
              child: RequestRenderer(
                request: localRequestDVO,
                currentAddress: 'a current address',
                chooseFile: () async => null,
                expandFileReference: (_) async => throw Exception('Not implemented'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadJsonData() async {
    final jsonData = await rootBundle.loadString('assets/DecidableShareAttributeRequestItem.json');

    setState(() => jsonExample = jsonDecode(jsonData));
  }
}
