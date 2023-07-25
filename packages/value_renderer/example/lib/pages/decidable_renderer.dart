import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class DecidableRenderer extends StatelessWidget {
  const DecidableRenderer({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    List<dynamic> items = data['items'];

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text('Decidable Renderer'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          // Text(data["value"]["@type"]),
          // const SizedBox(
          //   height: 12,
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: data["items"].length,
              itemBuilder: (context, index) {
                // String key = data["renderHints"]["propertyHints"].keys.elementAt(index);
                String? title = items[index]['title'];
                bool? isDecidable = items[index]['isDecidable'];
                bool? mustBeAccepted = items[index]['mustBeAccepted'];

                List<dynamic>? nestedItems = items[index]['items'];

                return Column(
                  children: [
                    ListTile(
                      title: Text(title ?? ''),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nestedItems?.length ?? 0,
                      itemBuilder: (context, nestedIndex) {
                        String? fieldName = nestedItems?[nestedIndex]['attribute']['value']['@type'];
                        String? initialValue = nestedItems?[nestedIndex]['attribute']['value']['value'];
                        dynamic values = nestedItems?[nestedIndex]['attribute']['valueHints']['values'];
                        RenderHintsEditType? editType = parseEditType(nestedItems?[nestedIndex]['attribute']['renderHints']['editType']);
                        RenderHintsTechnicalType? technicalType =
                            parseTechnicalType(nestedItems?[nestedIndex]['attribute']['renderHints']['technicalType']);

                        return ListTile(
                            title: ValueRenderer(
                          fieldName: fieldName,
                          editType: editType,
                          technicalType: technicalType,
                          initialValue: initialValue,
                          values: values,
                        ));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
