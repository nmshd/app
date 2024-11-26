import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identity_recovery_kit/identity_recovery_kit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate PDF',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const defaultQrData =
    'nmshd://tr#TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gU3VzcGVuZGlzc2Ugdm9sdXRwYXQgZWxpdCBhIG1hc3NhIGx1Y3R1cyBtYXR0aXMuIERvbmVjIHF1aXMgdmVoaWN1bGEgc2FwaWVuLCBhIGVsZW1lbnR1bSBlbmltLiBNb3JiaSBldSBzYXBpZW4gbWFzc2EuIER1aXMgbWFnbmEgc2VtLCBlZmZpY2l0dXIgdmVsIG1vbGxpcyB2aXRhZSwgZmV1Z2lhdCBpZCB2ZWxpdC4gSW4gc2l0IGFtZXQgbWF1cmlzIG1ldHVzLiBNYXVyaXMgYXQgaWFjdWxpcyBxdWFtLiBBbGlxdWFtIGVyYXQgdm9sdXRwYXQuIEN1cmFiaXR1ciB2YXJpdXMgZXVpc21vZCBhdWd1ZSwgcXVpcyBtb2xlc3RpZSBudW5jIHVsdHJpY2VzIHZpdGFlLiBDdXJhYml0dXIganVzdG8gcHVydXMsIGF1Y3RvciBzY2VsZXJpc3F1ZSBhbnRlIGV1LCB2aXZlcnJhIHN1c2NpcGl0IGxvcmVtLiBOdW5jIGlwc3VtIHR1cnBpcywgaW1wZXJkaWV0IGVnZXQgdml2ZXJyYSBlZ2V0LCBjb25zZXF1YXQgc2VkIGRpYW0uIEluIG5pc2wgbGVjdHVzLCBzY2VsZXJpc3F1ZSBzaXQgYW1ldCB2ZWxpdCBpZCwgZnJpbmdpbGxhIGFjY3Vtc2FuIGxvcmVtLiBDcmFzIGx1Y3R1cyBsYWNpbmlhIG5pYmggc2l0IGFtZXQgaW50ZXJkdW0uIE51bGxhbSBlZ2VzdGFzIGV1aXNtb2QgbnVsbGEgdmVsIHVsdHJpY2VzLg==';
const headerTitle = 'Wiederherstellungskit für\nIhre Enmeshed-Daten';
const keepSafeText =
    'Bitte bewahren Sie dieses Wiederherstellungs-Kit an einem für Dritte unzugänglichen Ort auf. Sobald Sie das selbst gewählte Master Passwort hier notiert haben ist ein Zugriff auf Ihre Enmeshed-Daten möglich.';
const infoText1 =
    'Drucken Sie dieses Dokument aus oder speichern Sie es an einem sicheren Ort, beispielsweise einem weiteren Mobilgerät oder Ihrem Computer.';
const infoText2 =
    'Schreiben Sie in das untenstehende Feld das Passwort, das Sie bei der Erstellung des Kits vergeben haben. Zur Wiederherstellung Ihrer verschlüsselten Daten benötigen Sie den QR Code und das von Ihnen vergebene Passwort.';
const idLabel = 'Enmeshed ID';
const id = 'did:e:nmshd-bkb.enmeshed.de:dids:4fe203de633a66b56730e3';
const passwordLabel = 'Passwort';
const qrDescription =
    'Wenn Sie Ihr Endgerät verloren haben sollten oder keinen Zugriff mehr darauf haben, scannen Sie einfach den QR Code mit einem neuen Endgerät um wieder Zugang zu Ihren Enmeshed-Daten zu erhalten.';
const needHelpTitle = 'Benötigen Sie Hilfe?';
const needHelpText = 'Wenden Sie sich an den Enmeshed-Support: support@enmeshed.de';
const headerTitleHexColor = '#CD5038';
const backgroundHexColor = '#D0E6F3';
const defaultTextHexColor = '#004F79';
const borderHexColor = '#006685';
const labelHexColor = '#006685';
const idHexColor = '#0077B6';

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'QR data'),
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              onPressed: () async {
                final spacerSvgImage = await rootBundle.loadString('assets/triangle.svg');
                final logoImageData = await rootBundle.load('assets/logo.png');
                final logoBytes = logoImageData.buffer.asUint8List();

                final generatedPdf = await PdfGenerator.generate(
                  logoBytes: logoBytes,
                  spacerSvgImage: spacerSvgImage,
                  truncatedReference: _controller.text,
                  headerTitle: headerTitle,
                  keepSafeText: keepSafeText,
                  infoText1: infoText1,
                  infoText2: infoText2,
                  idLabel: idLabel,
                  id: id,
                  passwordLabel: passwordLabel,
                  qrDescription: qrDescription,
                  needHelpTitle: needHelpTitle,
                  needHelpText: needHelpText,
                  headerTitleHexColor: headerTitleHexColor,
                  backgroundHexColor: backgroundHexColor,
                  defaultTextHexColor: defaultTextHexColor,
                  borderHexColor: borderHexColor,
                  labelHexColor: labelHexColor,
                  idHexColor: idHexColor,
                );

                final directory = await getTemporaryDirectory();
                final filePath = '${directory.path}/Identity Recovery Kit.pdf';

                final file = File(filePath);
                await file.writeAsBytes(generatedPdf);

                await OpenFile.open(filePath);
              },
              child: const Text('Generate PDF'),
            ),
            const SizedBox(height: 36),
            TextButton(onPressed: () => setState(() => _controller.text = defaultQrData), child: const Text('Set default data'))
          ],
        ),
      ),
    );
  }
}
