import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class InputExamples extends StatefulWidget {
  const InputExamples({
    super.key,
  });

  @override
  State<InputExamples> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<InputExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text('Input Examples'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(228, 255, 255, 255),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(children: <Widget>[
                      Text(
                        'String',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 1.0,
                      ),
                      ValueRenderer(technicalType: RenderHintsTechnicalType.String),
                      ValueRenderer(technicalType: RenderHintsTechnicalType.String, dataType: RenderHintsDataType.DateTime),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.String,
                        editType: RenderHintsEditType.ButtonLike,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.String,
                        editType: RenderHintsEditType.SelectLike,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.String,
                        editType: RenderHintsEditType.SliderLike,
                      ),
                    ]),
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(228, 255, 255, 255),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Number',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 1.0,
                      ),
                      ValueRenderer(technicalType: RenderHintsTechnicalType.Integer),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Integer,
                        editType: RenderHintsEditType.SelectLike,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Integer,
                        editType: RenderHintsEditType.ButtonLike,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Integer,
                        editType: RenderHintsEditType.SliderLike,
                        valueHintsValue: true,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Integer,
                        editType: RenderHintsEditType.SliderLike,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(228, 255, 255, 255),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Boolean',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 1.0,
                      ),
                      ValueRenderer(technicalType: RenderHintsTechnicalType.Boolean),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Boolean,
                        editType: RenderHintsEditType.ButtonLike,
                        valueHintsValue: true,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Boolean,
                        editType: RenderHintsEditType.SelectLike,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Boolean,
                        editType: RenderHintsEditType.SliderLike,
                      ),
                      ValueRenderer(
                        technicalType: RenderHintsTechnicalType.Boolean,
                        editType: RenderHintsEditType.SliderLike,
                        valueHintsValue: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
