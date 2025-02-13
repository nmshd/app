import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AcceptRequestItemParameters toJson', () {
    test('is correctly converted', () {
      const acceptRequestItemParameters = AcceptRequestItemParameters();
      final json = acceptRequestItemParameters.toJson();
      expect(json, equals({'accept': true}));
    });
  });
}
