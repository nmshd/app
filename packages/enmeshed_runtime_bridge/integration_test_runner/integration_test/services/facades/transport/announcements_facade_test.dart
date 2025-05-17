import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Session session;

  setUpAll(() async {
    final account = await runtime.accountServices.createAccount(name: 'announcementsFacade Test');
    session = runtime.getSession(account.id);
  });

  group('[AnnouncementsFacade] getAnnouncements', () {
    test('should give access to existing Announcements', () async {
      final announcementsResult = await session.transportServices.announcements.getAnnouncements(language: 'en');

      expect(announcementsResult, isSuccessful<List<AnnouncementDTO>>());

      final announcements = announcementsResult.value;
      expect(announcements, isEmpty);
    });

    test('should return proper error code when passing invalid language', () async {
      final announcementsResult = await session.transportServices.announcements.getAnnouncements(language: 'eng');

      expect(announcementsResult, isFailing('error.runtime.validation.invalidPropertyValue'));
    });
  });
}
