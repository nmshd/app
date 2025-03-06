import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:renderers/src/request/request_item_renderer/authentication_request_item_renderer.dart';

void main() {
  group('AuthenticationRequestItemRenderer', () {
    testWidgets('Renderer displays correct text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [FlutterI18nDelegate(translationLoader: null)],
          home: const Material(
            child: AuthenticationRequestItemRenderer(
              item: AuthenticationRequestItemDVO(
                id: 'id',
                name: 'authenticationRequestItem',
                mustBeAccepted: false,
                isDecidable: false,
                title: 'aTitle',
              ),
            ),
          ),
        ),
      );

      expect(find.text('DecidableAuthenticationRequestItem'), findsOneWidget);
      expect(find.text('authenticationRequestItem'), findsOneWidget);
    });
  }, skip: true);
}

class FakeTranslationLoader extends TranslationLoader {
  @override
  Future<Map> load() {
    return Future.value({'i18n://dvo.requestItem.DecidableAuthenticationRequestItem.name': 'DecidableAuthenticationRequestItem'});
  }
}
