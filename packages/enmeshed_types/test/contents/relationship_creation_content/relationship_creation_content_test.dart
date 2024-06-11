import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipCreationContent fromJson', () {
    test('parsed valid RelationshipCreationContent', () {
      final relationshipCreationContentJson = {
        '@type': 'RelationshipCreationContent',
        'response': const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: []).toJson(),
      };
      final relationshipCreationContent = RelationshipCreationContent.fromJson(relationshipCreationContentJson);
      expect(relationshipCreationContent, isA<RelationshipCreationContentWithResponse>());
    });

    test('parsed valid ArbitraryRelationshipCreationContent when not given a Response', () {
      final arbitraryRelationshipCreationContentJson = {
        '@type': 'RelationshipCreationContent',
        'internalJson': 'anInternalJson',
      };
      final arbitraryRelationshipCreationContent = RelationshipCreationContent.fromJson(arbitraryRelationshipCreationContentJson);
      expect(arbitraryRelationshipCreationContent, isA<ArbitraryRelationshipCreationContent>());
    });
  });
}
