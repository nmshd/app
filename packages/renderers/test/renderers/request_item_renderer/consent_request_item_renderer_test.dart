import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:renderers/renderers.dart';
import 'package:renderers/src/renderers/request_item_renderer/consent_request_item_renderer.dart';

@GenerateNiceMocks([MockSpec<AbstractUrlLauncher>()])
@GenerateNiceMocks([MockSpec<Logger>()])
import 'consent_request_item_renderer_test.mocks.dart';

void main() {
  final urlLauncherMock = MockAbstractUrlLauncher();
  final loggerMock = MockLogger();

  setUp(() {
    reset(urlLauncherMock);
    reset(loggerMock);
  });

  setUpAll(() {
    GetIt.I.registerSingleton<AbstractUrlLauncher>(urlLauncherMock);
    GetIt.I.registerSingleton<Logger>(loggerMock);
  });

  group('ConsentRequestItemRenderer', () {
    testWidgets(
      'renderer displayed correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: ConsentRequestItemRenderer(
                item: ConsentRequestItemDVO(
                  id: 'id',
                  name: 'consentRequestItem',
                  mustBeAccepted: false,
                  isDecidable: false,
                  consent: 'my consent text',
                ),
              ),
            ),
          ),
        );

        expect(find.text('my consent text').first, findsOneWidget);
        expect(find.byIcon(Icons.open_in_new), findsNothing);
      },
    );

    testWidgets(
      'renderer displays correctly with link',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: Material(
            child: ConsentRequestItemRenderer(
              item: ConsentRequestItemDVO(
                id: 'id',
                name: 'consentRequestItem',
                mustBeAccepted: false,
                isDecidable: false,
                consent: 'my consent text',
                link: 'my link',
              ),
            ),
          ),
        ));

        expect(find.text('my consent text').first, findsOneWidget);
        expect(find.byIcon(Icons.open_in_new), findsOneWidget);
      },
    );

    testWidgets(
      'renderer launches url',
      (WidgetTester tester) async {
        const url = 'my valid url';

        when(urlLauncherMock.canLaunchUrl(Uri.parse(url))).thenAnswer((_) async => true);
        when(urlLauncherMock.launchUrl(Uri.parse(url))).thenAnswer((_) async => true);

        await tester.pumpWidget(const MaterialApp(
          home: Material(
            child: ConsentRequestItemRenderer(
              item: ConsentRequestItemDVO(
                id: 'id',
                name: 'consentRequestItem',
                mustBeAccepted: false,
                isDecidable: false,
                consent: 'my consent text',
                link: url,
              ),
            ),
          ),
        ));

        expect(find.text('my consent text').first, findsOneWidget);
        expect(find.byIcon(Icons.open_in_new), findsOneWidget);

        await tester.tap(find.byIcon(Icons.open_in_new));
        await tester.pump();

        verify(urlLauncherMock.canLaunchUrl(Uri.parse(url))).called(1);
        verify(urlLauncherMock.launchUrl(Uri.parse(url))).called(1);
      },
    );

    testWidgets(
      'renderer logs correctly with invalid link',
      (WidgetTester tester) async {
        const url = 'my invalid url';

        when(urlLauncherMock.canLaunchUrl(Uri.parse(url))).thenAnswer((_) async => false);

        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: ConsentRequestItemRenderer(
                item: ConsentRequestItemDVO(
                  id: 'id',
                  name: 'consentRequestItem',
                  mustBeAccepted: false,
                  isDecidable: false,
                  consent: 'my consent text',
                  link: url,
                ),
              ),
            ),
          ),
        );

        expect(find.text('my consent text').first, findsOneWidget);
        expect(find.byIcon(Icons.open_in_new), findsOneWidget);

        await tester.tap(find.byIcon(Icons.open_in_new));
        await tester.pump();

        verify(urlLauncherMock.canLaunchUrl(Uri.parse(url))).called(1);
        verifyNever(urlLauncherMock.launchUrl(Uri.parse(url)));
        expect(verify(loggerMock.e(captureAny)).captured.single, 'Could not launch ${Uri.parse(url)}');
      },
    );
  });
}
