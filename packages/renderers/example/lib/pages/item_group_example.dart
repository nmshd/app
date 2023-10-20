import 'dart:convert';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class ItemGroupExample extends StatefulWidget {
  const ItemGroupExample({super.key});

  @override
  State<ItemGroupExample> createState() => _ItemGroupExampleState();
}

class _ItemGroupExampleState extends State<ItemGroupExample> {
  Map<String, dynamic>? jsonExample;

  RequestRendererController controller = RequestRendererController();

  DecideRequestParameters? requestController;
  RequestValidationResultDTO? _validationResult;

  @override
  void initState() {
    loadJsonData();
    super.initState();

    controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (controller.value == null) return;

        final result = await GetIt.I.get<EnmeshedRuntime>().currentSession.consumptionServices.incomingRequests.canAccept(params: controller.value!);
        if (result.isError) return GetIt.I.get<Logger>().e(result.error);

        setState(() => _validationResult = result.value);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (jsonExample == null) return const CircularProgressIndicator();
    final localRequestDVO = LocalRequestDVO.fromJson(jsonExample!);
    return SingleChildScrollView(
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
          RequestRenderer(request: localRequestDVO, controller: controller, validationResult: _validationResult),
          FilledButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(minimumSize: const Size(100.0, 36.0)),
            child: const Text('save'),
          ),
        ],
      ),
    );
  }

  Future<void> loadJsonData() async {
    final jsonData = await rootBundle.loadString('assets/request_example_group.json');

    setState(() => jsonExample = jsonDecode(jsonData));
  }
}
