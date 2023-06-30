import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Value Renderer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ValueRenderer(technicalType: RenderHintsTechnicalType.String),
              ValueRenderer(technicalType: RenderHintsTechnicalType.Integer),
              ValueRenderer(
                technicalType: RenderHintsTechnicalType.Integer,
                editType: RenderHintsEditType.SliderLike,
              ),
              ValueRenderer(technicalType: RenderHintsTechnicalType.Boolean),
              ValueRenderer(
                technicalType: RenderHintsTechnicalType.Boolean,
                valueHintsValue: true,
              ),
              ValueRenderer(
                technicalType: RenderHintsTechnicalType.Boolean,
                editType: RenderHintsEditType.SelectLike,
              ),
              ValueRenderer(editType: RenderHintsEditType.SelectLike),
              ValueRenderer(technicalType: RenderHintsTechnicalType.String, dataType: RenderHintsDataType.DateTime),
            ],
          ),
        ),
      ),
    );
  }
}
