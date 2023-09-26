import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

class RequestRendererController extends ValueNotifier<dynamic> {
  RequestRendererController() : super(null);
}

class RequestRenderer extends StatelessWidget {
  final RequestRendererController? controller;
  final LocalRequestDVO? request;

  const RequestRenderer({super.key, this.controller, this.request});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
