import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class Renderer extends StatelessWidget {
  const Renderer({super.key, required this.data});

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
                String? title = items[index]['title'];
                bool? isDecidable = items[index]['isDecidable'];
                bool? mustBeAccepted = items[index]['mustBeAccepted'];

                List<dynamic>? nestedItems = items[index]['items'];

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nestedItems?.length ?? 0,
                      itemBuilder: (context, nestedIndex) {
                        String? fieldName = nestedItems?[nestedIndex]['attribute']['value']['@type'];
                        Map<String, dynamic>? initialValue = nestedItems?[nestedIndex]['attribute']['value'];
                        Map<String, dynamic>? valueHints = nestedItems?[nestedIndex]['attribute']['valueHints'];
                        Map<String, dynamic>? renderHints = nestedItems?[nestedIndex]['attribute']['renderHints'];

                        return ListTile(
                            title: ValueRenderer(
                          fieldName: fieldName,
                          initialValue: initialValue,
                          renderHints: renderHints ?? {},
                          valueHints: valueHints ?? {},
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
