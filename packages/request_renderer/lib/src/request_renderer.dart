import 'package:flutter/widgets.dart';

class RequestRendererController extends ValueNotifier<dynamic> {
  RequestRendererController() : super(null);
}

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;

  const RequestRenderer({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
