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

  group('AcceptRequestItemParameters toJson', () {
    test('is correctly converted', () {
      const acceptRequestItemParameters = AcceptRequestItemParameters();
      final json = acceptRequestItemParameters.toJson();
      expect(
        json,
        equals({'accept': true}),
      );
    });
  });

  group('RejectRequestItemParameters toJson', () {
    test('is correctly converted', () {
      const rejectRequestItemParameters = RejectRequestItemParameters();
      final json = rejectRequestItemParameters.toJson();
      expect(
        json,
        equals({'accept': false}),
      );
    });

    test('is correctly converted with property "code"', () {
      const rejectRequestItemParameters = RejectRequestItemParameters(code: 'aCode');
      final json = rejectRequestItemParameters.toJson();
      expect(
        json,
        equals({'accept': false, 'code': 'aCode'}),
      );
    });

    test('is correctly converted with property "message"', () {
      const rejectRequestItemParameters = RejectRequestItemParameters(message: 'aMessage');
      final json = rejectRequestItemParameters.toJson();
      expect(
        json,
        equals({'accept': false, 'message': 'aMessage'}),
      );
    });

    test('is correctly converted with properties "code" and "message"', () {
      const rejectRequestItemParameters = RejectRequestItemParameters(code: 'aCode', message: 'aMessage');
      final json = rejectRequestItemParameters.toJson();
      expect(
        json,
        equals({'accept': false, 'code': 'aCode', 'message': 'aMessage'}),
      );
    });
  });
}
