import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';

import '../../setup.dart';
import 'consumption/attributes_facade_test.dart' as attributes_facade_test;
import 'consumption/requests_facade_test.dart' as requests_facade_test;

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) async {
  attributes_facade_test.run(runtime);
  requests_facade_test.run(runtime);
}
