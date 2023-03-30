import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Pseudonym(value: 'aPseudonym');
  group('Pseudonym to json', () {
    test('valid Pseudonym', () {
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

  group('Pseudonym from json', () {
    test('valid Pseudonym', () {
      final json = {'value': 'aPseudonym'};
      expect(Pseudonym.fromJson(json), equals(identityAttributeValue));
    });
  });
}
