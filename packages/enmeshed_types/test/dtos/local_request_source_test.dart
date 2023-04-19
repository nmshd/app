import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalRequestSourceDTO toJson', () {
    test('is correctly converted', () {
      const dto = LocalRequestSourceDTO(type: LocalRequestSourceType.Message, reference: 'aReference');
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({'type': 'Message', 'reference': 'aReference'}),
      );
    });
  });

  group('LocalRequestSourceDTO fromJson', () {
    test('is correctly converted', () {
      final json = {'type': 'Message', 'reference': 'aReference'};
      expect(
        LocalRequestSourceDTO.fromJson(json),
        equals(const LocalRequestSourceDTO(type: LocalRequestSourceType.Message, reference: 'aReference')),
      );
    });
  });
}
