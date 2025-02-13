import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalResponseSourceDTO toJson', () {
    test('is correctly converted', () {
      const dto = LocalResponseSourceDTO(type: LocalResponseSourceType.Message, reference: 'aReference');
      final dtoJson = dto.toJson();
      expect(dtoJson, equals({'type': 'Message', 'reference': 'aReference'}));
    });
  });

  group('LocalResponseSourceDTO fromJson', () {
    test('is correctly converted', () {
      final json = {'type': 'Message', 'reference': 'aReference'};
      expect(
        LocalResponseSourceDTO.fromJson(json),
        equals(const LocalResponseSourceDTO(type: LocalResponseSourceType.Message, reference: 'aReference')),
      );
    });
  });
}
