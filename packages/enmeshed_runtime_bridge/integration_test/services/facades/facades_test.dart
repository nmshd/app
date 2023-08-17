import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';

import '../../setup.dart';
import 'anonymous_test.dart' as anonymous_test;
import 'consumption_test.dart' as consumption_test;
import 'transport_test.dart' as transport_test;

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) async {
  anonymous_test.run(runtime);
  consumption_test.run(runtime);
  transport_test.run(runtime);
}
