import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipTemplateContent toJson', () {
    test('is correctly converted', () {
      const relationshipTemplateContent = RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      );
      final relationshipTemplateJson = relationshipTemplateContent.toJson();
      expect(
        relationshipTemplateJson,
        equals({
          '@type': 'RelationshipTemplateContent',
          'onNewRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const relationshipTemplateContent = RelationshipTemplateContent(
        title: 'aTitle',
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      );
      final relationshipTemplateJson = relationshipTemplateContent.toJson();
      expect(
        relationshipTemplateJson,
        equals({
          '@type': 'RelationshipTemplateContent',
          'title': 'aTitle',
          'onNewRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const relationshipTemplateContent = RelationshipTemplateContent(
        metadata: {},
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      );
      final relationshipTemplateJson = relationshipTemplateContent.toJson();
      expect(
        relationshipTemplateJson,
        equals({
          '@type': 'RelationshipTemplateContent',
          'metadata': {},
          'onNewRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        }),
      );
    });

    test('is correctly converted with property "onExistingRelationship"', () {
      const relationshipTemplateContent = RelationshipTemplateContent(
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
        onExistingRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      );
      final relationshipTemplateJson = relationshipTemplateContent.toJson();
      expect(
        relationshipTemplateJson,
        equals({
          '@type': 'RelationshipTemplateContent',
          'onNewRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
          'onExistingRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        }),
      );
    });

    test('is correctly converted with properties "title", "metadata" and "onExistingRelationship"', () {
      const relationshipTemplateContent = RelationshipTemplateContent(
        title: 'aTitle',
        metadata: {},
        onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
        onExistingRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
      );
      final relationshipTemplateJson = relationshipTemplateContent.toJson();
      expect(
        relationshipTemplateJson,
        equals({
          '@type': 'RelationshipTemplateContent',
          'title': 'aTitle',
          'metadata': {},
          'onNewRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
          'onExistingRelationship':
              const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        }),
      );
    });
  });

  group('RelationshipTemplateContent fromJson', () {
    test('is correctly converted', () {
      final json = {
        'onNewRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
      };
      expect(
        RelationshipTemplateContent.fromJson(json),
        equals(
          const RelationshipTemplateContent(
            onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
          ),
        ),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {
        'title': 'aTitle',
        'onNewRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
      };
      expect(
        RelationshipTemplateContent.fromJson(json),
        equals(
          const RelationshipTemplateContent(
            title: 'aTitle',
            onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
          ),
        ),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'onNewRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
      };
      expect(
        RelationshipTemplateContent.fromJson(json),
        equals(
          const RelationshipTemplateContent(
            metadata: {'aKey': 'aValue'},
            onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
          ),
        ),
      );
    });

    test('is correctly converted with property "onExistingRelationship"', () {
      final json = {
        'onNewRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        'onExistingRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
      };
      expect(
        RelationshipTemplateContent.fromJson(json),
        equals(
          const RelationshipTemplateContent(
            onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
            onExistingRelationship: Request(
              items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
            ),
          ),
        ),
      );
    });

    test('is correctly converted with properties "title", "metadata" and "onExistingRelationship"', () {
      final json = {
        'title': 'aTitle',
        'metadata': {'aKey': 'aValue'},
        'onNewRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
        'onExistingRelationship':
            const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]).toJson(),
      };
      expect(
        RelationshipTemplateContent.fromJson(json),
        equals(
          const RelationshipTemplateContent(
            title: 'aTitle',
            metadata: {'aKey': 'aValue'},
            onNewRelationship: Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]),
            onExistingRelationship: Request(
              items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
            ),
          ),
        ),
      );
    });
  });
}
