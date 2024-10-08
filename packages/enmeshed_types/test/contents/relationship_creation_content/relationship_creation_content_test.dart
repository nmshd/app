import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipCreationContent toJson', () {
    test('is correctly converted', () {
      const relationshipCreationContent = RelationshipCreationContent(
        response: Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ),
      );
      final relationshipCreationContentJson = relationshipCreationContent.toJson();
      expect(
        relationshipCreationContentJson,
        equals({
          '@type': 'RelationshipCreationContent',
          'response': const Response(
            result: ResponseResult.Accepted,
            requestId: 'aRequestId',
            items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
          ).toJson(),
        }),
      );
    });
  });

  group('RelationshipCreationContent fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'RelationshipCreationContent',
        'response': const Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ).toJson(),
      };
      expect(
        RelationshipCreationContent.fromJson(json),
        equals(const RelationshipCreationContent(
          response: Response(
            result: ResponseResult.Accepted,
            requestId: 'aRequestId',
            items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
          ),
        )),
      );
    });
  });
}
