import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

class OpenId4VpIntroductionView extends StatefulWidget {
  final String presentationRequestUrl;
  final String accountId;

  const OpenId4VpIntroductionView({required this.presentationRequestUrl, required this.accountId, super.key});

  @override
  State<OpenId4VpIntroductionView> createState() => _OpenId4VpIntroductionViewState();
}

class _OpenId4VpIntroductionViewState extends State<OpenId4VpIntroductionView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _progressAnimation = Tween<double>(begin: 1 / 3, end: 2 / 3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onProceedPressed(BuildContext context) async {
    // _controller.forward();
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final result = session.consumptionServices.openId4Vc.fetchPresentationRequest(widget.presentationRequestUrl);
    // await _controller.forward(); // Wait for animation before navigating
    await result.then((response) {
      if (context.mounted) {
        context.pushReplacement(
          '/account/${widget.accountId}/verifiable-credentials/resolved-presentation',
          extra: response.value,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(24 + 64 + 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 64, 8, 32),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) => LinearProgressIndicator(
              value: _progressAnimation.value,
              minHeight: 24,
              borderRadius: BorderRadius.circular(2),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const VectorGraphic(loader: AssetBytesLoader('assets/svg/create_recovery_kit.svg'), height: 160),
                  const SizedBox(height: 24),
                  const Text(
                    'OpenID4VP is a protocol that allows you to present your digital credentials securely. '
                    'You have received a presentation request. You can proceed to resolve and accept this request, or cancel to go back. '
                    'Upon Proceeding you will have a chance to review which credentials will be shared with the requester.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Presentation Request URL:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    widget.presentationRequestUrl,
                    style: const TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => _onProceedPressed(context),
                        child: const Text(
                          'Proceed',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
