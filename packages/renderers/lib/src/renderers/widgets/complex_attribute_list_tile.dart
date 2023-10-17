import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class ComplexAttributeListTile extends StatelessWidget {
  final String title;
  final List<String> titles;
  final List<String?> subTitles;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const ComplexAttributeListTile({super.key, required this.title, required this.titles, required this.subTitles, this.trailing, this.onPressed});

  @override
  Widget build(BuildContext context) {
    const titlesTextStyle = TextStyle(fontSize: 12, color: Color(0xFF42474E));

    final listOfTitles = [];
    final listOfSubTitles = [];
    for (int i = 0; i < subTitles.length; i++) {
      if (subTitles[i] != null) {
        listOfTitles.add(titles[i]);
        listOfSubTitles.add(subTitles[i]!);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 16),
            TranslatedText(title, style: const TextStyle(fontSize: 16, color: Color(0xFF42474E))),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listOfTitles.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TranslatedText('${listOfTitles[index]}', style: titlesTextStyle),
                          const Text(':', style: titlesTextStyle),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(listOfSubTitles[index], style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: 96, child: trailing ?? IconButton(onPressed: onPressed, icon: const Icon(Icons.info))),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 0),
      ],
    );
  }
}
