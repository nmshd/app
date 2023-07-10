import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:value_renderer/value_renderer.dart';

void main() {
  runApp(const MyApp());
}

Future<Map<String, dynamic>> loadJsonData() async {
  String jsonData = await rootBundle.loadString('assets/address.json');
  Map<String, dynamic> data = jsonDecode(jsonData);

  return data;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Map<String, dynamic>>(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(title: 'Value Renderer', data: snapshot.data!);
          } else if (snapshot.hasError) {
            return const Text('Error loading JSON data');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title, required this.data});

  final String title;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value Renderer'),
      ),
      body: Column(
        children: [
          Text(data["value"]["@type"]),
          Expanded(
            child: ListView.builder(
              itemCount: data["renderHints"]["propertyHints"].length,
              itemBuilder: (context, index) {
                String key = data["renderHints"]["propertyHints"].keys.elementAt(index);
                dynamic techType = data["renderHints"]["propertyHints"][key]["technicalType"];
                dynamic dataType = data["renderHints"]["propertyHints"][key]["dataType"];
                dynamic editType = data["renderHints"]["propertyHints"][key]["editType"];

                return ListTile(
                  title: Text('$key: $techType, $editType, $dataType'),
                  subtitle: showInput(techType, editType),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

showInput(techType, editType) {
  if (editType == 'SelectLike') {
    return const ValueRenderer(
      technicalType: RenderHintsTechnicalType.String,
      editType: RenderHintsEditType.SelectLike,
    );
  } else if (techType == 'String') {
    return const ValueRenderer(
      technicalType: RenderHintsTechnicalType.String,
    );
  }
}
