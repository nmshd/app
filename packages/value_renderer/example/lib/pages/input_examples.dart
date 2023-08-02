import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class InputExamples extends StatelessWidget {
  final RequestDVO data;

  const InputExamples({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final items = data.items;

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
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final title = item is RequestItemGroupDVO ? item.title : null;
                final nestedItems = item is RequestItemGroupDVO ? item.items : null;

                return Padding(
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
                              ListTile(
                                title: Text(
                                  title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.blue,
                                thickness: 1.0,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: nestedItems?.length ?? 0,
                                itemBuilder: (context, nestedIndex) {
                                  final String? fieldName = nestedItems?[nestedIndex]['attribute']['value']['@type'];
                                  final Map<String, dynamic>? initialValue = nestedItems?[nestedIndex]['attribute']['value'];
                                  final Map<String, dynamic>? valueHints = nestedItems?[nestedIndex]['attribute']['valueHints'];
                                  final Map<String, dynamic>? valueHints = nestedItems?[nestedIndex]['attribute']['valueHints'];
                                  final Map<String, dynamic>? renderHints = nestedItems?[nestedIndex]['attribute']['renderHints'];

                                  return ListTile(
                                    title: ValueRenderer(
                                      fieldName: fieldName,
                                      initialValue: initialValue,
                                      renderHints: renderHints ?? {},
                                      valueHints: valueHints ?? {},
                                    ),
                                  );
                                },
                              ),
                            ]),
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
