import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalAttributeListenerDTO toJson', () {
    test('is correctly converted', () {
      const dto = LocalAttributeListenerDTO(
        id: 'anId',
        query: IdentityAttributeQuery(valueType: 'aValueType'),
        peer: 'aPeer',
      );
      final dtoJson = dto.toJson();
      expect(dtoJson, equals({'id': 'anId', 'query': const IdentityAttributeQuery(valueType: 'aValueType').toJson(), 'peer': 'aPeer'}));
    });
  });

  group('LocalAttributeListenerDTO fromJson', () {
    test('is correctly converted', () {
      final json = {'id': 'anId', 'query': const IdentityAttributeQuery(valueType: 'aValueType').toJson(), 'peer': 'aPeer'};
      expect(
        LocalAttributeListenerDTO.fromJson(json),
        equals(
          const LocalAttributeListenerDTO(
            id: 'anId',
            query: IdentityAttributeQuery(valueType: 'aValueType'),
            peer: 'aPeer',
          ),
        ),
      );
    });
  });
}
