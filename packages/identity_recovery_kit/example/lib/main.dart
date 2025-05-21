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
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
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

const defaultQrData = 'https://backbone.example.com/r/ANID1234?app=anAppName#M3xsZXJKeVg4eWRKREVYb3dxMlBNTW50UlhYQTI3d2dISllBX0JqbkZ4NTVZfHw';
const headerTitle = 'Recovery Kit for\nYour Enmeshed Data';
const keepSafeText =
    'Please store this recovery kit in a location inaccessible to others. Once you have noted down the master password you chose yourself, access to your Enmeshed data will be possible.';
const infoText1 = 'Print this document or save it in a secure location, such as another mobile device or your computer.';
const infoText2 =
    'Write the password you set when creating the kit in the field below. To restore your encrypted data, you will need the QR code and the password you created.';
const addressLabel = 'Enmeshed ID';
const address = 'did:e:backbone.example.com:dids:4fe203de633a66b56730e3';
const passwordLabel = 'Password';
const qrDescription =
    'If you have lost your device or no longer have access to it, simply scan the QR code with a new device to regain access to your Enmeshed data.';
const needHelpTitle = 'Need Help?';
const needHelpText = 'Contact Enmeshed Support: support@enmeshed.de';
const headerTitleHexColor = '#CD5038';
const backgroundHexColor = '#D0E6F3';
const defaultTextHexColor = '#004F79';
const borderHexColor = '#006685';
const labelHexColor = '#006685';
const addressHexColor = '#0077B6';

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _backupURLController = TextEditingController();
  final TextEditingController _headerTitleController = TextEditingController();
  final TextEditingController _keepSafeTextController = TextEditingController();
  final TextEditingController _infoText1Controller = TextEditingController();
  final TextEditingController _infoText2Controller = TextEditingController();
  final TextEditingController _addressLabelController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordLabelController = TextEditingController();
  final TextEditingController _qrDescriptionController = TextEditingController();
  final TextEditingController _needHelpTitleController = TextEditingController();
  final TextEditingController _needHelpTextController = TextEditingController();
  final TextEditingController _headerTitleHexColorController = TextEditingController();
  final TextEditingController _backgroundHexColorController = TextEditingController();
  final TextEditingController _defaultTextHexColorController = TextEditingController();
  final TextEditingController _borderHexColorController = TextEditingController();
  final TextEditingController _labelHexColorController = TextEditingController();
  final TextEditingController _addressHexColorController = TextEditingController();

  QRErrorCorrectionLevel _selectedErrorCorrectionLevel = QRErrorCorrectionLevel.L;

  @override
  void dispose() {
    super.dispose();

    _backupURLController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _backupURLController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Backup URL'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _headerTitleController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Header title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _keepSafeTextController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Keep safe text'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _infoText1Controller,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Info text 1'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _infoText2Controller,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Info text 2'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressLabelController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Address label'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Address'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordLabelController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Password label'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _qrDescriptionController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'QR description'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _needHelpTitleController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Need help title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _needHelpTextController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Need help text'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _headerTitleHexColorController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Header title hex color'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _backgroundHexColorController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Background hex color'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _defaultTextHexColorController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Default text hex color'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _borderHexColorController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Border hex color'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _labelHexColorController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Label hex color'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressHexColorController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Address hex color'),
            ),
            const SizedBox(height: 12),
            const Text('QR error correction level:'),
            const SizedBox(height: 6),
            SegmentedButton(
              segments: const [
                ButtonSegment(value: QRErrorCorrectionLevel.L, label: Text('Low')),
                ButtonSegment(value: QRErrorCorrectionLevel.M, label: Text('Medium')),
                ButtonSegment(value: QRErrorCorrectionLevel.Q, label: Text('Quartile')),
                ButtonSegment(value: QRErrorCorrectionLevel.H, label: Text('High')),
              ],
              showSelectedIcon: false,
              selected: {_selectedErrorCorrectionLevel},
              onSelectionChanged: (value) => setState(() => _selectedErrorCorrectionLevel = value.first),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                OutlinedButton(onPressed: () => setState(_setDefaultValues), child: const Text('Set default data')),
                const SizedBox(width: 12),
                FilledButton(onPressed: _generatePDF, child: const Text('Generate PDF')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _setDefaultValues() {
    _backupURLController.text = defaultQrData;
    _headerTitleController.text = headerTitle;
    _keepSafeTextController.text = keepSafeText;
    _infoText1Controller.text = infoText1;
    _infoText2Controller.text = infoText2;
    _addressLabelController.text = addressLabel;
    _addressController.text = address;
    _passwordLabelController.text = passwordLabel;
    _qrDescriptionController.text = qrDescription;
    _needHelpTitleController.text = needHelpTitle;
    _needHelpTextController.text = needHelpText;
    _headerTitleHexColorController.text = headerTitleHexColor;
    _backgroundHexColorController.text = backgroundHexColor;
    _defaultTextHexColorController.text = defaultTextHexColor;
    _borderHexColorController.text = borderHexColor;
    _labelHexColorController.text = labelHexColor;
    _addressHexColorController.text = addressHexColor;
  }

  void _generatePDF() async {
    final spacerSvgImage = await rootBundle.loadString('assets/triangle.svg');
    final logoImageData = await rootBundle.load('assets/logo.png');
    final logoBytes = logoImageData.buffer.asUint8List();

    final generatedPdf = await PdfGenerator(
      headerTitleHexColor: _headerTitleHexColorController.text,
      backgroundHexColor: _backgroundHexColorController.text,
      defaultTextHexColor: _defaultTextHexColorController.text,
      borderHexColor: _borderHexColorController.text,
      labelHexColor: _labelHexColorController.text,
      addressHexColor: _addressHexColorController.text,
      pdfTexts: (
        headerTitle: _headerTitleController.text,
        keepSafeText: _keepSafeTextController.text,
        infoText1: _infoText1Controller.text,
        infoText2: _infoText2Controller.text,
        addressLabel: _addressLabelController.text,
        address: _addressController.text,
        passwordLabel: _passwordLabelController.text,
        qrDescription: _qrDescriptionController.text,
        needHelpTitle: _needHelpTitleController.text,
        needHelpText: _needHelpTextController.text,
      ),
      qrSettings: (errorCorrectionLevel: _selectedErrorCorrectionLevel, qrPixelSize: null),
    ).generate(logoBytes: logoBytes, spacerSvgImage: spacerSvgImage, backupURL: _backupURLController.text);

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/Identity Recovery Kit.pdf';

    final file = File(filePath);
    await file.writeAsBytes(generatedPdf);

    await OpenFile.open(filePath);
  }
}
