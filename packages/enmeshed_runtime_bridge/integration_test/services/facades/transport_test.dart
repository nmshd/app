import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';

import '../../setup.dart';
import 'transport/account_facade_test.dart' as account_facade_test;
import 'transport/devices_facade_test.dart' as devices_facade_test;
import 'transport/files_facade_test.dart' as files_facade_test;
import 'transport/messages_facade_test.dart' as messages_facade_test;
import 'transport/relationship_template_facade_test.dart' as relationship_template_facade_test;
import 'transport/relationships_facade_test.dart' as relationships_facade_test;
import 'transport/tokens_facade_test.dart' as tokens_facade_test;

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) async {
  account_facade_test.run(runtime);
  devices_facade_test.run(runtime);
  files_facade_test.run(runtime);
  messages_facade_test.run(runtime);
  relationship_template_facade_test.run(runtime);
  relationships_facade_test.run(runtime);
  tokens_facade_test.run(runtime);
}
