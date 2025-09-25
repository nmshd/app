import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OpenIdPresentationAcceptedView extends StatefulWidget {
  final int response;

  const OpenIdPresentationAcceptedView({required this.response, super.key});

  @override
  State<OpenIdPresentationAcceptedView> createState() => _OpenIdPresentationAcceptedViewState();
}

class _OpenIdPresentationAcceptedViewState extends State<OpenIdPresentationAcceptedView> {
  late Map<String, dynamic> payload;
  late String storedClaim;

  @override
  void initState() {
    super.initState();
    payload = {};
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(24 + 64 + 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 64, 8, 32),
          child: LinearProgressIndicator(
            value: 1,
            minHeight: 24,
            borderRadius: BorderRadius.circular(2),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Card(
                color: widget.response == 200 ? Colors.green[100] : Colors.red[100],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.response == 200 ? Icons.check_circle : Icons.cancel,
                        color: widget.response == 200 ? Colors.green.shade700 : Colors.red.shade700,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.response == 200 ? 'Presentation success' : 'Presentation failed - code: ${widget.response}',
                        style: TextStyle(
                          fontSize: 18,
                          color: widget.response == 200 ? Colors.green.shade700 : Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    child: const Text(
                      'Back to Credentials',
                      style: TextStyle(fontSize: 18),
                    ),
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
