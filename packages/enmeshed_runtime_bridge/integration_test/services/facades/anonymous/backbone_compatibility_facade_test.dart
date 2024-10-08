import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  group('BackboneCompatibilityFacade', () {
    test('should successfully check the compatibility', () async {
      final result = await runtime.anonymousServices.backboneCompatibility.checkBackboneCompatibility();
      expect(result, isSuccessful<CheckBackboneCompatibilityResponse>());

      expect(result.value.isCompatible, true);
    });
  });
}
