import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DecideRequestParameters toJson', () {
    test('is correctly converted', () {
      const decideRequestParameters = DecideRequestParameters(requestId: 'aRequestId', items: [AcceptRequestItemParameters()]);
      final json = decideRequestParameters.toJson();
      expect(
        json,
        equals({
          'requestId': 'aRequestId',
          'items': [const AcceptRequestItemParameters().toJson()],
        }),
      );
    });
  });
}
