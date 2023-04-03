import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipCreationChangeRequestContent toJson', () {
    test('is correctly converted', () {
      const relationshipCreationChangeRequestContent = RelationshipCreationChangeRequestContent(
        response: Response(
          result: 'aResult',
          requestId: 'aRequestId',
          items: [],
        ),
      );
      final relationshipCreationChangeRequestContentJson = relationshipCreationChangeRequestContent.toJson();
      expect(
        relationshipCreationChangeRequestContentJson,
        equals({
          '@type': 'RelationshipCreationChangeRequestContent',
          'response': const Response(result: 'aResult', requestId: 'aRequestId', items: []).toJson(),
        }),
      );
    });
  });

  group('RelationshipCreationChangeRequestContent fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'RelationshipCreationChangeRequestContent',
        'response': const Response(result: 'aResult', requestId: 'aRequestId', items: []).toJson(),
      };
      expect(
        RelationshipCreationChangeRequestContent.fromJson(json),
        equals(const RelationshipCreationChangeRequestContent(
          response: Response(
            result: 'aResult',
            requestId: 'aRequestId',
            items: [],
          ),
        )),
      );
    });
  });
}
