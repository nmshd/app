import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ChallengeDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'expiresAt': 'anExpiryDate',
        'createdBy': 'aCreatorAddress',
        'createdByDevice': 'aCreatorDeviceId',
        'type': 'Relationship',
        'signature': 'aSignature',
        'challengeString': 'aChallengeString',
      };
      expect(
        ChallengeDTO.fromJson(json),
        equals(const ChallengeDTO(
          id: 'anId',
          expiresAt: 'anExpiryDate',
          createdBy: 'aCreatorAddress',
          createdByDevice: 'aCreatorDeviceId',
          type: ChallengeType.Relationship,
          signature: 'aSignature',
          challengeString: 'aChallengeString',
        )),
      );
    });
  });
}
