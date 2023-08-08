import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class InputExamples extends StatelessWidget {
  const InputExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text('Input Examples'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Expanded(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: <Widget>[
                        const ListTile(
                          title: Text(
                            'String',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(editType: RenderHintsEditType.SelectLike, technicalType: RenderHintsTechnicalType.String),
                          valueHints: const ValueHints(
                            values: [
                              ValueHintsValue(key: 'AF', displayName: 'i18n://attributes.values.countries.AF'),
                              ValueHintsValue(key: 'AL', displayName: 'i18n://attributes.values.countries.AL'),
                              ValueHintsValue(key: 'DE', displayName: 'i18n://attributes.values.countries.DE'),
                            ],
                            max: 2,
                            min: 2,
                          ),
                          initialValue: const {'@type': 'Nationality', 'value': 'DE'},
                        ),
                      ]),
                    )),
              ],
            ),
          )),
          Expanded(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: <Widget>[
                        const ListTile(
                          title: Text(
                            'Boolean',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(editType: RenderHintsEditType.SelectLike, technicalType: RenderHintsTechnicalType.String),
                          valueHints: const ValueHints(
                            values: [
                              ValueHintsValue(key: 'AF', displayName: 'i18n://attributes.values.countries.AF'),
                              ValueHintsValue(key: 'AL', displayName: 'i18n://attributes.values.countries.AL'),
                              ValueHintsValue(key: 'DE', displayName: 'i18n://attributes.values.countries.DE'),
                            ],
                            max: 2,
                            min: 2,
                          ),
                          initialValue: const {'@type': 'Nationality', 'value': 'DE'},
                        ),
                      ]),
                    )),
              ],
            ),
          )),
          Expanded(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: <Widget>[
                        const ListTile(
                          title: Text(
                            'Number',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(editType: RenderHintsEditType.SelectLike, technicalType: RenderHintsTechnicalType.String),
                          valueHints: const ValueHints(
                            values: [
                              ValueHintsValue(key: 'AF', displayName: 'i18n://attributes.values.countries.AF'),
                              ValueHintsValue(key: 'AL', displayName: 'i18n://attributes.values.countries.AL'),
                              ValueHintsValue(key: 'DE', displayName: 'i18n://attributes.values.countries.DE'),
                            ],
                            max: 2,
                            min: 2,
                          ),
                          initialValue: const {'@type': 'Nationality', 'value': 'DE'},
                        ),
                      ]),
                    )),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
