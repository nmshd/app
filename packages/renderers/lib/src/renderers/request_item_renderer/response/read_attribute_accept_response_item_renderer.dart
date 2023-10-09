import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

class ReadAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ReadAttributeAcceptResponseItemDVO item;
  const ReadAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text(item.attribute.value.toString()),
        const SizedBox(height: 30),
      ],
    );
  }
}
