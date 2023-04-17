import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DecideRequestItemGroupParameters toJson', () {
    test('is correctly converted', () {
      const decideRequestItemGroupParameters = DecideRequestItemGroupParameters(items: [AcceptRequestItemParameters()]);
      final json = decideRequestItemGroupParameters.toJson();
      expect(
        json,
        equals({
          'items': [const AcceptRequestItemParameters().toJson()],
        }),
      );
    });
  });
}
