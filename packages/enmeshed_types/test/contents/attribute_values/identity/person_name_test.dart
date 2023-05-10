import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('PersonNameAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = PersonNameAttributeValue(givenName: 'aGivenName', surname: 'aSurname');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname'}),
      );
    });

    test('is correctly converted with property "middleName"', () {
      const identityAttributeValue = PersonNameAttributeValue(givenName: 'aGivenName', middleName: 'aMiddleName', surname: 'aSurname');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'middleName': 'aMiddleName', 'surname': 'aSurname'}),
      );
    });

    test('is correctly converted with property "honorificSuffix"', () {
      const identityAttributeValue = PersonNameAttributeValue(givenName: 'aGivenName', surname: 'aSurname', honorificSuffix: 'aHonorificSuffix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificSuffix': 'aHonorificSuffix'}),
      );
    });

    test('is correctly converted with property "honorificPrefix"', () {
      const identityAttributeValue = PersonNameAttributeValue(givenName: 'aGivenName', surname: 'aSurname', honorificPrefix: 'aHonorificPrefix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificPrefix': 'aHonorificPrefix'}),
      );
    });

    test('is correctly converted with properties "middleName", "honorificSuffix" and "honorificPrefix"', () {
      const identityAttributeValue = PersonNameAttributeValue(
        givenName: 'aGivenName',
        middleName: 'aMiddleName',
        surname: 'aSurname',
        honorificSuffix: 'aHonorificSuffix',
        honorificPrefix: 'aHonorificPrefix',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'PersonName',
          'givenName': 'aGivenName',
          'middleName': 'aMiddleName',
          'surname': 'aSurname',
          'honorificSuffix': 'aHonorificSuffix',
          'honorificPrefix': 'aHonorificPrefix',
        }),
      );
    });
  });

  group('PersonNameAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname'};
      expect(PersonNameAttributeValue.fromJson(json), equals(const PersonNameAttributeValue(givenName: 'aGivenName', surname: 'aSurname')));
    });

    test('is correctly converted with property "middleName"', () {
      final json = {'givenName': 'aGivenName', 'middleName': 'aMiddleName', 'surname': 'aSurname'};
      expect(
        PersonNameAttributeValue.fromJson(json),
        equals(const PersonNameAttributeValue(givenName: 'aGivenName', middleName: 'aMiddleName', surname: 'aSurname')),
      );
    });

    test('is correctly converted with property "honorificSuffix"', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificSuffix': 'aHonorificSuffix'};
      expect(
        PersonNameAttributeValue.fromJson(json),
        equals(const PersonNameAttributeValue(givenName: 'aGivenName', surname: 'aSurname', honorificSuffix: 'aHonorificSuffix')),
      );
    });

    test('is correctly converted with property "honorificPrefix"', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificPrefix': 'aHonorificPrefix'};
      expect(
        PersonNameAttributeValue.fromJson(json),
        equals(const PersonNameAttributeValue(givenName: 'aGivenName', surname: 'aSurname', honorificPrefix: 'aHonorificPrefix')),
      );
    });

    test('is correctly converted with properties "middleName", "honorificSuffix" and "honorificPrefix"', () {
      final json = {
        'givenName': 'aGivenName',
        'middleName': 'aMiddleName',
        'surname': 'aSurname',
        'honorificSuffix': 'aHonorificSuffix',
        'honorificPrefix': 'aHonorificPrefix',
      };
      expect(
        PersonNameAttributeValue.fromJson(json),
        equals(const PersonNameAttributeValue(
          givenName: 'aGivenName',
          middleName: 'aMiddleName',
          surname: 'aSurname',
          honorificSuffix: 'aHonorificSuffix',
          honorificPrefix: 'aHonorificPrefix',
        )),
      );
    });
  });
}
