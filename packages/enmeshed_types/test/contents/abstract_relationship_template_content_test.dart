import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AbstractRelationshipTemplateContent fromJson', () {
    test('parsed valid RelationshipTemplateContent', () {
      final json = {
        '@type': 'RelationshipTemplateContent',
        'onNewRelationship': const Request(items: []).toJson(),
      };
      final relationshipRequestContent = RelationshipTemplateContentDerivation.fromJson(json);
      expect(relationshipRequestContent, isA<RelationshipTemplateContent>());
    });

    test('parsed valid ArbitraryRelationshipTemplateContent when given an unknown @type', () {
      final json = {
        '@type': 'unknownType',
        'internalJson': 'anInternalJson',
      };
      final relationshipRequestContent = RelationshipTemplateContentDerivation.fromJson(json);
      expect(relationshipRequestContent, isA<ArbitraryRelationshipTemplateContent>());
    });
  });
}
