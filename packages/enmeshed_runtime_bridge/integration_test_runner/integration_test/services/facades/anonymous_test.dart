import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';

import '../../setup.dart';
import 'anonymous/anonymous_tokens_facade_test.dart' as anonymous_tokens_facade_test;
import 'anonymous/backbone_compatibility_facade_test.dart' as backbone_compatibility_facade_test;

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) async {
  anonymous_tokens_facade_test.run(runtime);
  backbone_compatibility_facade_test.run(runtime);
}
