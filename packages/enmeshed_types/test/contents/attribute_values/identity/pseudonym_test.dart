import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Pseudonym toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = PseudonymAttributeValue(value: 'aPseudonym');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Pseudonym',
          'value': 'aPseudonym',
        }),
      );
    });
  });

  group('Pseudonym fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aPseudonym'};
      expect(PseudonymAttributeValue.fromJson(json), equals(const PseudonymAttributeValue(value: 'aPseudonym')));
    });
  });
}
