// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:renderers/src/renderers/request_item_renderer/authentication_request_item_renderer.dart';
import 'package:renderers/src/request_renderer.dart';

void main() {
  group('AuthenticationRequestItemRenderer', () {
    testWidgets(
      'Renderer displays correct text',
      (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: AuthenticationRequestItemRenderer(
            item: const AuthenticationRequestItemDVO(
              id: 'id',
              name: 'authenticationRequestItem',
              mustBeAccepted: false,
              isDecidable: false,
            ),
            controller: RequestRendererController(),
          ),
        ));

        expect(find.text('authenticationRequestItem'), findsOneWidget);
      },
    );
  });
}
