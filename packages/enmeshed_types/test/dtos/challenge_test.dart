import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ChallengeDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'expiresAt': 'anExpiryDate',
        'type': 'Relationship',
        'signature': 'aSignature',
        'challengeString': 'aChallengeString',
      };
      expect(
        ChallengeDTO.fromJson(json),
        equals(
          const ChallengeDTO(
            id: 'anId',
            expiresAt: 'anExpiryDate',
            type: ChallengeType.Relationship,
            signature: 'aSignature',
            challengeString: 'aChallengeString',
          ),
        ),
      );
    });

    test('is correctly converted with propertiy "createdBy"', () {
      final json = {
        'id': 'anId',
        'expiresAt': 'anExpiryDate',
        'createdBy': 'aCreatorAddress',
        'type': 'Relationship',
        'signature': 'aSignature',
        'challengeString': 'aChallengeString',
      };
      expect(
        ChallengeDTO.fromJson(json),
        equals(
          const ChallengeDTO(
            id: 'anId',
            expiresAt: 'anExpiryDate',
            createdBy: 'aCreatorAddress',
            type: ChallengeType.Relationship,
            signature: 'aSignature',
            challengeString: 'aChallengeString',
          ),
        ),
      );
    });

    test('is correctly converted with property "createdByDevice"', () {
      final json = {
        'id': 'anId',
        'expiresAt': 'anExpiryDate',
        'createdByDevice': 'aCreatorDeviceId',
        'type': 'Relationship',
        'signature': 'aSignature',
        'challengeString': 'aChallengeString',
      };
      expect(
        ChallengeDTO.fromJson(json),
        equals(
          const ChallengeDTO(
            id: 'anId',
            expiresAt: 'anExpiryDate',
            createdByDevice: 'aCreatorDeviceId',
            type: ChallengeType.Relationship,
            signature: 'aSignature',
            challengeString: 'aChallengeString',
          ),
        ),
      );
    });

    test('is correctly converted with properties "createdBy" and "createdByDevice"', () {
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
        equals(
          const ChallengeDTO(
            id: 'anId',
            expiresAt: 'anExpiryDate',
            createdBy: 'aCreatorAddress',
            createdByDevice: 'aCreatorDeviceId',
            type: ChallengeType.Relationship,
            signature: 'aSignature',
            challengeString: 'aChallengeString',
          ),
        ),
      );
    });
  });
}
