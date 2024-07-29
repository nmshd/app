import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipCreationContent fromJson', () {
    test('parsed valid RelationshipCreationContent', () {
      final relationshipCreationContentJson = {
        '@type': 'RelationshipCreationContent',
        'response': const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: []).toJson(),
      };
      final relationshipCreationContent = RelationshipCreationContentDerivation.fromJson(relationshipCreationContentJson);
      expect(relationshipCreationContent, isA<RelationshipCreationContent>());
    });

    test('parsed valid ArbitraryRelationshipCreationContent', () {
      final arbitraryRelationshipCreationContentJson = {
        '@type': 'ArbitraryRelationshipCreationContent',
        'value': 'value',
      };
      final arbitraryRelationshipCreationContent = RelationshipCreationContentDerivation.fromJson(arbitraryRelationshipCreationContentJson);
      expect(arbitraryRelationshipCreationContent, isA<ArbitraryRelationshipCreationContent>());
    });

    group('RelationshipCreationContent fromJson with exception', () {
      test('throws exception when @type is missing', () {
        final json = {};
        expect(() => RelationshipCreationContent.fromJson(json), throwsA(isA<Exception>()));
      });

      test('throws exception when type is unknown', () {
        final json = {'@type': 'UnknownType'};
        expect(() => RelationshipCreationContent.fromJson(json), throwsA(isA<Exception>()));
      });
    });
  });
}
