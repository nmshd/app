import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

import 'setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime enmeshedRuntime) {
  test('getEditableAttributes returns a list of strings and contains StreetAddress', () async {
    final attributes = await enmeshedRuntime.getEditableAttributes();

    expect(attributes, isA<List<String>>());
    expect(attributes.isNotEmpty, true);
    expect(attributes.contains('StreetAddress'), true);
  });
}
