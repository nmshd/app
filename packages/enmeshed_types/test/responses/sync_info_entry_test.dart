import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('SyncInfoEntry toJson', () {
    test('is correctly converted', () {
      const entry = SyncInfoEntry(completedAt: '2023');
      final entryJson = entry.toJson();
      expect(entryJson, equals({'completedAt': '2023'}));
    });
  });

  group('SyncInfoEntry fromJson', () {
    test('is correctly converted', () {
      final json = {'completedAt': '2023'};
      expect(SyncInfoEntry.fromJson(json), equals(const SyncInfoEntry(completedAt: '2023')));
    });
  });
}
