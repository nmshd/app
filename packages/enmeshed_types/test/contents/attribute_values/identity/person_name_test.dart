import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('PersonName toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', surname: 'aSurname');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname'}),
      );
    });

    test('is correctly converted with property "middleName"', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', middleName: 'aMiddleName', surname: 'aSurname');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'middleName': 'aMiddleName', 'surname': 'aSurname'}),
      );
    });

    test('is correctly converted with property "honorificSuffix"', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificSuffix: 'aHonorificSuffix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificSuffix': 'aHonorificSuffix'}),
      );
    });

    test('is correctly converted with property "honorificPrefix"', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificPrefix: 'aHonorificPrefix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificPrefix': 'aHonorificPrefix'}),
      );
    });

    test('is correctly converted with properties "middleName", "honorificSuffix" and "honorificPrefix"', () {
      const identityAttributeValue = PersonName(
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

  group('PersonName fromJson', () {
    test('is correctly converted', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', surname: 'aSurname')));
    });

    test('is correctly converted with property "middleName"', () {
      final json = {'givenName': 'aGivenName', 'middleName': 'aMiddleName', 'surname': 'aSurname'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', middleName: 'aMiddleName', surname: 'aSurname')));
    });

    test('is correctly converted with property "honorificSuffix"', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificSuffix': 'aHonorificSuffix'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificSuffix: 'aHonorificSuffix')));
    });

    test('is correctly converted with property "honorificPrefix"', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificPrefix': 'aHonorificPrefix'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificPrefix: 'aHonorificPrefix')));
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
        PersonName.fromJson(json),
        equals(const PersonName(
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
