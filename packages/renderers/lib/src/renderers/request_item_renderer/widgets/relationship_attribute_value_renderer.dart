import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

class RelationshipAttributeValueRenderer extends StatelessWidget {
  final List<IdentityAttributeDVO>? results;
  final RelationshipAttributeValue value;

  const RelationshipAttributeValueRenderer({super.key, required this.value, this.results});

  @override
  Widget build(BuildContext context) {
    return Text(value.toString());
  }
}
