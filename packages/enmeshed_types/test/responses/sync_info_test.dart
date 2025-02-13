import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('SyncInfoResponse toJson', () {
    test('is correctly converted', () {
      const response = SyncInfoResponse();
      final responseJson = response.toJson();
      expect(responseJson, equals({}));
    });

    test('is correctly converted with property "lastDatawalletSync"', () {
      const response = SyncInfoResponse(lastDatawalletSync: SyncInfoEntry(completedAt: '2023'));
      final responseJson = response.toJson();
      expect(responseJson, equals({'lastDatawalletSync': const SyncInfoEntry(completedAt: '2023').toJson()}));
    });

    test('is correctly converted with property "lastSyncRun"', () {
      const response = SyncInfoResponse(lastSyncRun: SyncInfoEntry(completedAt: '2023'));
      final responseJson = response.toJson();
      expect(responseJson, equals({'lastSyncRun': const SyncInfoEntry(completedAt: '2023').toJson()}));
    });

    test('is correctly converted with properties "lastDatawalletSync" and "lastSyncRun"', () {
      const response = SyncInfoResponse(lastDatawalletSync: SyncInfoEntry(completedAt: '2023'), lastSyncRun: SyncInfoEntry(completedAt: '2023'));
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({
          'lastDatawalletSync': const SyncInfoEntry(completedAt: '2023').toJson(),
          'lastSyncRun': const SyncInfoEntry(completedAt: '2023').toJson(),
        }),
      );
    });
  });

  group('SyncInfoResponse fromJson', () {
    test('is correctly converted', () {
      expect(SyncInfoResponse.fromJson(const {}), equals(const SyncInfoResponse()));
    });

    test('is correctly converted with property "lastDatawalletSync"', () {
      final json = {'lastDatawalletSync': const SyncInfoEntry(completedAt: '2023').toJson()};
      expect(SyncInfoResponse.fromJson(json), equals(const SyncInfoResponse(lastDatawalletSync: SyncInfoEntry(completedAt: '2023'))));
    });

    test('is correctly converted with property "lastSyncRun"', () {
      final json = {'lastSyncRun': const SyncInfoEntry(completedAt: '2023').toJson()};
      expect(SyncInfoResponse.fromJson(json), equals(const SyncInfoResponse(lastSyncRun: SyncInfoEntry(completedAt: '2023'))));
    });

    test('is correctly converted with properties "lastDatawalletSync" and "lastSyncRun"', () {
      final json = {
        'lastDatawalletSync': const SyncInfoEntry(completedAt: '2023').toJson(),
        'lastSyncRun': const SyncInfoEntry(completedAt: '2023').toJson(),
      };
      expect(
        SyncInfoResponse.fromJson(json),
        equals(const SyncInfoResponse(lastDatawalletSync: SyncInfoEntry(completedAt: '2023'), lastSyncRun: SyncInfoEntry(completedAt: '2023'))),
      );
    });
  });
}
