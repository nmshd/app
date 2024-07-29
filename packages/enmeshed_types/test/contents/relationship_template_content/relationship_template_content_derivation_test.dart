import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipTemplateContent fromJson', () {
    test('parsed valid RelationshipTemplateContent', () {
      final json = {
        '@type': 'RelationshipTemplateContent',
        'onNewRelationship': const Request(items: []).toJson(),
      };
      final relationshipRequestContent = RelationshipTemplateContentDerivation.fromJson(json);
      expect(relationshipRequestContent, isA<RelationshipTemplateContent>());
    });

    test('parsed valid ArbitraryRelationshipTemplateContent', () {
      final json = {
        '@type': 'unknownType',
        'internalJson': 'anInternalJson',
      };
      final relationshipRequestContent = RelationshipTemplateContentDerivation.fromJson(json);
      expect(relationshipRequestContent, isA<ArbitraryRelationshipTemplateContent>());
    });

    group('RelationshipTemplateContent fromJson with exception', () {
      test('throws exception when @type is missing', () {
        final json = {};
        expect(() => RelationshipTemplateContent.fromJson(json), throwsA(isA<Exception>()));
      });

      test('throws exception when type is unknown', () {
        final json = {'@type': 'UnknownType'};
        expect(() => RelationshipTemplateContent.fromJson(json), throwsA(isA<Exception>()));
      });
    });
  });
}
