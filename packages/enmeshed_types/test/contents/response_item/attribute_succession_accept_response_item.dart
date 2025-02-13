import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AttributeSuccessionAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = AttributeSuccessionAcceptResponseItem(
        predecessorId: 'aPredecessorId',
        successorId: 'aSuccessorId',
        successorContent: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({
          '@type': 'AttributeSuccessionAcceptResponseItem',
          'result': 'Accepted',
          'predecessorId': 'aPredecessorId',
          'successorId': 'aSuccessorId',
          'successorContent': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });
  });

  group('AttributeSuccessionAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'predecessorId': 'aPredecessorId',
        'successorId': 'aSuccessorId',
        'successorContent': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        AttributeSuccessionAcceptResponseItem.fromJson(json),
        equals(
          const AttributeSuccessionAcceptResponseItem(
            predecessorId: 'aPredecessorId',
            successorId: 'aSuccessorId',
            successorContent: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });
  });
}
