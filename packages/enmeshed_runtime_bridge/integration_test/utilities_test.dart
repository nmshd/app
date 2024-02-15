import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime enmeshedRuntime) {
  test('getEditableAttributes returns a list of strings and contains StreetAddress', () async {
    final valueTypes = await enmeshedRuntime.getEditableAttributes();

    expect(valueTypes, isA<List<String>>());
    expect(valueTypes.isNotEmpty, true);
    expect(valueTypes.contains('StreetAddress'), true);
  });

  test('getHints returns a GetHintsResponse', () async {
    final valueTypes = await enmeshedRuntime.getEditableAttributes();

    final hints = await enmeshedRuntime.getHints(valueTypes.first);

    expect(hints, isSuccessful<GetHintsResponse>());
  });
}
