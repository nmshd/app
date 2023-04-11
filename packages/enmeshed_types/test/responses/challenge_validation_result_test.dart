import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ChallengeValidationResult fromJson', () {
    test('is correctly converted', () {
      final json = {'isValid': true};
      expect(
        ChallengeValidationResult.fromJson(json),
        equals(const ChallengeValidationResult(isValid: true)),
      );
    });

    test('is correctly converted with property "correspondingRelationship"', () {
      final relationshipDTO = RelationshipDTO(
        id: 'id',
        template: RelationshipTemplateDTO(
          id: 'id',
          isOwn: false,
          createdBy: 'createdBy',
          createdByDevice: 'createdByDevice',
          createdAt: 'createdAt',
          content: ArbitraryRelationshipTemplateContent(const {}),
          truncatedReference: 'truncatedReference',
        ),
        status: RelationshipStatus.Active,
        peer: 'peer',
        peerIdentity: IdentityDTO(address: 'address', publicKey: 'publicKey', realm: 'realm'),
        changes: const [],
      );

      final json = {'isValid': true, 'correspondingRelationship': relationshipDTO.toJson()};

      expect(
        ChallengeValidationResult.fromJson(json).correspondingRelationship,
        equals(ChallengeValidationResult(isValid: true, correspondingRelationship: relationshipDTO).correspondingRelationship),
      );

      expect(
        ChallengeValidationResult.fromJson(json),
        equals(ChallengeValidationResult(isValid: true, correspondingRelationship: relationshipDTO)),
      );
    });
  });
}
