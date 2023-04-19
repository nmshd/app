import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipChangeRequestContent fromJson', () {
    test('parsed valid RelationshipCreationChangeRequestContent', () {
      final relationshipCreationChangeRequestContentJson = {
        '@type': 'RelationshipCreationChangeRequestContent',
        'response': const Response(result: 'aResult', requestId: 'aRequestId', items: []).toJson(),
      };
      final relationshipChangeRequestContent = RelationshipChangeRequestContent.fromJson(relationshipCreationChangeRequestContentJson);
      expect(relationshipChangeRequestContent, isA<RelationshipCreationChangeRequestContent>());
    });

    test('parsed valid ArbitraryRelationshipChangeRequestContent when given an unknown @type', () {
      final arbitraryRelationshipChangeRequestContentJson = {
        '@type': 'unknownType',
        'internalJson': 'anInternalJson',
      };
      final arbitraryRelationshipChangeRequestContent = RelationshipChangeRequestContent.fromJson(arbitraryRelationshipChangeRequestContentJson);
      expect(arbitraryRelationshipChangeRequestContent, isA<ArbitraryRelationshipChangeRequestContent>());
    });
  });
}
