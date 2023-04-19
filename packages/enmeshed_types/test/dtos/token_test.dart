import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('TokenDTO toJson', () {
    test('is correctly converted', () {
      const dto = TokenDTO(
        id: 'anId',
        createdBy: 'aCreator',
        createdByDevice: 'aCreatorDeviceId',
        content: ArbitraryTokenContent({'aKey': 'aValue'}),
        createdAt: '2023',
        expiresAt: '2024',
        secretKey: 'aSecretKey',
        truncatedReference: 'aTruncatedReference',
        isEphemeral: true,
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'createdBy': 'aCreator',
          'createdByDevice': 'aCreatorDeviceId',
          'content': const ArbitraryTokenContent({'aKey': 'aValue'}).toJson(),
          'createdAt': '2023',
          'expiresAt': '2024',
          'secretKey': 'aSecretKey',
          'truncatedReference': 'aTruncatedReference',
          'isEphemeral': true,
        }),
      );
    });
  });

  group('TokenDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'createdBy': 'aCreator',
        'createdByDevice': 'aCreatorDeviceId',
        'content': const ArbitraryTokenContent({'aKey': 'aValue'}),
        'createdAt': '2023',
        'expiresAt': '2024',
        'secretKey': 'aSecretKey',
        'truncatedReference': 'aTruncatedReference',
        'isEphemeral': true,
      };
      expect(
        TokenDTO.fromJson(json),
        equals(const TokenDTO(
          id: 'anId',
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          content: ArbitraryTokenContent({'aKey': 'aValue'}),
          createdAt: '2023',
          expiresAt: '2024',
          secretKey: 'aSecretKey',
          truncatedReference: 'aTruncatedReference',
          isEphemeral: true,
        )),
      );
    });
  });
}
