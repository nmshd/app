import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Pseudonym(value: 'aPseudonym');
  group('Pseudonym toJson', () {
    test('is correctly converted', () {
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
      expect(Pseudonym.fromJson(json), equals(identityAttributeValue));
    });
  });
}
