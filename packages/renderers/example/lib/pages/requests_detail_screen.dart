import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class RequestsDetailScreen extends StatefulWidget {
  final String accountId;
  final LocalRequestDVO localRequestDVO;

  const RequestsDetailScreen({super.key, required this.accountId, required this.localRequestDVO});

  @override
  State<RequestsDetailScreen> createState() => _RequestsDetailScreenState();
}

class _RequestsDetailScreenState extends State<RequestsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Detail Screen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RequestRenderer(request: widget.localRequestDVO),
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
