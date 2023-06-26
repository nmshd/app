import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

import '../setup.dart';
import 'message_dvo_test.dart' as message_dvo_test;

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  group('[DataViewExpander]', () {
    message_dvo_test.run(runtime);
  });
}
