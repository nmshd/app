import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class RequestsDetailScreen extends StatefulWidget {
  final String accountId;
  final LocalRequestDVO localRequestDVO;

  const RequestsDetailScreen({super.key, required this.accountId, required this.localRequestDVO});

  @override
  State<RequestsDetailScreen> createState() => _RequestsDetailScreenState();
}

class _RequestsDetailScreenState extends State<RequestsDetailScreen> {
  late RequestRendererController controller;

  DecideRequestParameters? requestController;
  RequestValidationResultDTO? _validationResult;

  @override
  void initState() {
    super.initState();

    controller = RequestRendererController(request: widget.localRequestDVO);

    controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final result = await GetIt.I.get<EnmeshedRuntime>().currentSession.consumptionServices.incomingRequests.canAccept(params: controller.value);
        if (result.isError) return GetIt.I.get<Logger>().e(result.error);

        setState(() {
          _validationResult = result.value;
        });
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
    return Scaffold(
      appBar: AppBar(title: const Text('Message Detail Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
              TranslatedText(widget.localRequestDVO.name),
              const SizedBox(height: 8),
              if (widget.localRequestDVO.description != null) ...[
                const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(widget.localRequestDVO.description!),
                const SizedBox(height: 8),
              ],
              const Text('Request ID:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.localRequestDVO.id),
              const SizedBox(height: 8),
              const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
              TranslatedText(widget.localRequestDVO.statusText),
              const SizedBox(height: 8),
              const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.localRequestDVO.createdBy.name),
              const SizedBox(height: 8),
              const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(widget.localRequestDVO.createdAt))),
              RequestRenderer(
                request: widget.localRequestDVO,
                controller: controller,
                onEdit: () => _addEditItem(),
                validationResult: _validationResult,
                selectAttribute: createIdentityAttributeDVO,
              ),
              if (widget.localRequestDVO.isDecidable)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('cancel'),
                    ),
                    FilledButton(
                      onPressed: _validationResult != null && _validationResult!.isSuccess ? () {} : null,
                      style: OutlinedButton.styleFrom(minimumSize: const Size(100.0, 36.0)),
                      child: const Text('save'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<IdentityAttribute> createIdentityAttributeDVO({required String valueType}) async {
    await Future.delayed(const Duration(seconds: 3));

    return switch (valueType) {
      'DisplayName' => const IdentityAttribute(
          owner: '',
          value: DisplayNameAttributeValue(value: 'Alternative Display Name'),
        ),
      'GivenName' => const IdentityAttribute(
          owner: '',
          value: GivenNameAttributeValue(value: 'Alternative Given Name'),
        ),
      'Surname' => const IdentityAttribute(
          owner: '',
          value: SurnameAttributeValue(value: 'Alternative Surname'),
        ),
      'Nationality' => const IdentityAttribute(
          owner: '',
          value: NationalityAttributeValue(value: 'DE'),
        ),
      'CommunicationLanguage' => const IdentityAttribute(
          owner: '',
          value: CommunicationLanguageAttributeValue(value: 'de'),
        ),
      'BirthDate' => const IdentityAttribute(
          owner: '',
          value: BirthDateAttributeValue(day: 01, month: 01, year: 2000),
        ),
      'EMailAddress' => const IdentityAttribute(
          owner: '',
          value: EMailAddressAttributeValue(value: 'alternative@email.com'),
        ),
      'Sex' => const IdentityAttribute(
          owner: '',
          value: SexAttributeValue(value: 'male'),
        ),
      'StreetAddress' => const IdentityAttribute(
          owner: '',
          value: StreetAddressAttributeValue(
            recipient: 'Alternative Recepient',
            street: 'Alternative Street',
            houseNumber: 'Alternative House Number',
            zipCode: 'Alternative Zip Code',
            city: 'Alternative City',
            country: 'DE',
          ),
        ),
      _ => throw Exception('Invalid Value Type: $valueType'),
    };
  }

  void _addEditItem() {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => _AddEditItem(requestController: requestController!));
  }
}

class _AddEditItem extends StatefulWidget {
  final DecideRequestParameters requestController;

  const _AddEditItem({required this.requestController});

  @override
  State<_AddEditItem> createState() => __AddEditItemState();
}

class __AddEditItemState extends State<_AddEditItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslatedText(widget.requestController.toString()),
        ],
      ),
    );
  }
}
