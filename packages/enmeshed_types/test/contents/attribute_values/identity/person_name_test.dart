import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Birth Place to json', () {
    test('valid PersonName', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', surname: 'aSurname');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname'}),
      );
    });

    test('valid PersonName with middleName', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', middleName: 'aMiddleName', surname: 'aSurname');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'middleName': 'aMiddleName', 'surname': 'aSurname'}),
      );
    });

    test('valid PersonName with honorificSuffix', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificSuffix: 'aHonorificSuffix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificSuffix': 'aHonorificSuffix'}),
      );
    });

    test('valid PersonName with honorificPrefix', () {
      const identityAttributeValue = PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificPrefix: 'aHonorificPrefix');
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({'@type': 'PersonName', 'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificPrefix': 'aHonorificPrefix'}),
      );
    });

    test('valid PersonName with middleName, honorificSuffix and honorificPrefix', () {
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

  group('Birth Place from json', () {
    test('valid PersonName', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', surname: 'aSurname')));
    });

    test('valid PersonName with middleName', () {
      final json = {'givenName': 'aGivenName', 'middleName': 'aMiddleName', 'surname': 'aSurname'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', middleName: 'aMiddleName', surname: 'aSurname')));
    });

    test('valid PersonName with honorificSuffix', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificSuffix': 'aHonorificSuffix'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificSuffix: 'aHonorificSuffix')));
    });

    test('valid PersonName with honorificPrefix', () {
      final json = {'givenName': 'aGivenName', 'surname': 'aSurname', 'honorificPrefix': 'aHonorificPrefix'};
      expect(PersonName.fromJson(json), equals(const PersonName(givenName: 'aGivenName', surname: 'aSurname', honorificPrefix: 'aHonorificPrefix')));
    });

    test('valid PersonName with middleName, honorificSuffix and honorificPrefix', () {
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
