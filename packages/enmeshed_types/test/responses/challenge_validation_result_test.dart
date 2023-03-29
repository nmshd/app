import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ChallengeValidationResult fromJson', () {
    test('is correctly converted', () {
      // TODO: add test for correspondingRelationship as soon as the RelationshipDTO is tested

      final json = {'isValid': true};
      expect(
        ChallengeValidationResult.fromJson(json),
        equals(const ChallengeValidationResult(isValid: true)),
      );
    });
  });
}
