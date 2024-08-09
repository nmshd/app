import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipCreationContentDerivation fromJson', () {
    test('parsed valid RelationshipCreationContent', () {
      final relationshipCreationContentJson = {
        '@type': 'RelationshipCreationContentDerivation',
        'response': const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: []).toJson(),
      };
      final relationshipCreationContent = RelationshipCreationContentDerivation.fromJson(relationshipCreationContentJson);
      expect(relationshipCreationContent, isA<RelationshipCreationContent>());
    });

    test('parsed valid ArbitraryRelationshipCreationContent when not given a Response', () {
      final arbitraryRelationshipCreationContentJson = {
        '@type': 'RelationshipCreationContentDerivation',
        'internalJson': 'anInternalJson',
      };
      final arbitraryRelationshipCreationContent = RelationshipCreationContentDerivation.fromJson(arbitraryRelationshipCreationContentJson);
      expect(arbitraryRelationshipCreationContent, isA<ArbitraryRelationshipCreationContent>());
    });
  });
}
