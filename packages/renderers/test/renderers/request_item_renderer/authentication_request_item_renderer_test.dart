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
