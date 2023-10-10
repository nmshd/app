import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  RequestRendererController controller = RequestRendererController();

  dynamic requestController;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => requestController = controller.value);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
              const Divider(),
              Column(
                children: [
                  RequestRenderer(request: widget.localRequestDVO, controller: controller),
                  Text('controller: ${requestController ?? 'null'}'),
                ],
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
                      onPressed: () {},
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
}
