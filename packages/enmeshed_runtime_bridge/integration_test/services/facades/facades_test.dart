import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';

import '../../setup.dart';
import 'account_facade_test.dart' as account_facade_test;
import 'anonymous_tokens_facade_test.dart' as anonymous_tokens_facade_test;
import 'attributes_facade_test.dart' as attributes_facade_test;
import 'devices_facade_test.dart' as devices_facade_test;
import 'files_facade_test.dart' as files_facade_test;
import 'messages_facade_test.dart' as messages_facade_test;
import 'relationship_template_facade_test.dart' as relationship_template_facade_test;
import 'relationships_facade_test.dart' as relationships_facade_test;
import 'requests_facade_test.dart' as requests_facade_test;
import 'tokens_facade_test.dart' as tokens_facade_test;

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) async {
  relationship_template_facade_test.run(runtime);
  relationships_facade_test.run(runtime);
  files_facade_test.run(runtime);
  attributes_facade_test.run(runtime);
  account_facade_test.run(runtime);
  messages_facade_test.run(runtime);
  requests_facade_test.run(runtime);
  tokens_facade_test.run(runtime);
  anonymous_tokens_facade_test.run(runtime);
  devices_facade_test.run(runtime);
}
