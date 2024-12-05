import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalAttributeDTO toJson', () {
    test('is correctly converted', () {
      const dto = LocalAttributeDTO(
        id: 'anId',
        createdAt: '2023',
        content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "parentId"', () {
      const dto = LocalAttributeDTO(
        id: 'anId',
        parentId: 'aParentId',
        createdAt: '2023',
        content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'parentId': 'aParentId',
          'createdAt': '2023',
          'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "succeeds"', () {
      const dto = LocalAttributeDTO(
        id: 'anId',
        createdAt: '2023',
        content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        succeeds: 'succeed',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'succeeds': 'succeed',
        }),
      );
    });

    test('is correctly converted with property "succeededBy"', () {
      const dto = LocalAttributeDTO(
        id: 'anId',
        createdAt: '2023',
        content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        succeededBy: 'anAddress',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'succeededBy': 'anAddress',
        }),
      );
    });

    test('is correctly converted with property "shareInfo"', () {
      const dto = LocalAttributeDTO(
        id: 'anId',
        createdAt: '2023',
        content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        shareInfo: LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer'),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdAt': '2023',
          'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'shareInfo': const LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer').toJson(),
        }),
      );
    });

    test('is correctly converted with properties "parentId", "succeeds", "succeededBy" and "shareInfo"', () {
      const dto = LocalAttributeDTO(
        id: 'anId',
        parentId: 'aParentId',
        createdAt: '2023',
        content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        succeeds: 'succeed',
        succeededBy: 'anAddress',
        shareInfo: LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer'),
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'parentId': 'aParentId',
          'createdAt': '2023',
          'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'succeeds': 'succeed',
          'succeededBy': 'anAddress',
          'shareInfo': const LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer').toJson(),
        }),
      );
    });
  });

  group('LocalAttributeDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        LocalAttributeDTO.fromJson(json),
        equals(
          const LocalAttributeDTO(
            id: 'anId',
            createdAt: '2023',
            content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });

    test('is correctly converted with property "parentId"', () {
      final json = {
        'id': 'anId',
        'parentId': 'aParentId',
        'createdAt': '2023',
        'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        LocalAttributeDTO.fromJson(json),
        equals(const LocalAttributeDTO(
          id: 'anId',
          parentId: 'aParentId',
          createdAt: '2023',
          content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        )),
      );
    });

    test('is correctly converted with property "succeeds"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'succeeds': 'succeed',
      };
      expect(
        LocalAttributeDTO.fromJson(json),
        equals(const LocalAttributeDTO(
          id: 'anId',
          createdAt: '2023',
          content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          succeeds: 'succeed',
        )),
      );
    });

    test('is correctly converted with property "succeededBy"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'succeededBy': 'anAddress',
      };
      expect(
        LocalAttributeDTO.fromJson(json),
        equals(const LocalAttributeDTO(
          id: 'anId',
          createdAt: '2023',
          content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          succeededBy: 'anAddress',
        )),
      );
    });

    test('is correctly converted with property "shareInfo"', () {
      final json = {
        'id': 'anId',
        'createdAt': '2023',
        'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'shareInfo': const LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer').toJson(),
      };
      expect(
        LocalAttributeDTO.fromJson(json),
        equals(const LocalAttributeDTO(
          id: 'anId',
          createdAt: '2023',
          content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          shareInfo: LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer'),
        )),
      );
    });

    test('is correctly converted with properties "parentId", "succeeds", "succeededBy" and "shareInfo"', () {
      final json = {
        'id': 'anId',
        'parentId': 'aParentId',
        'createdAt': '2023',
        'content': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'succeeds': 'succeed',
        'succeededBy': 'anAddress',
        'shareInfo': const LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer').toJson(),
      };
      expect(
        LocalAttributeDTO.fromJson(json),
        equals(const LocalAttributeDTO(
          id: 'anId',
          parentId: 'aParentId',
          createdAt: '2023',
          content: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          succeeds: 'succeed',
          succeededBy: 'anAddress',
          shareInfo: LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer'),
        )),
      );
    });
  });
}
