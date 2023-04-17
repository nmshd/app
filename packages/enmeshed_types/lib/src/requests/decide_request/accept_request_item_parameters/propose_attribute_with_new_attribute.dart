import '../../../contents/abstract_attribute.dart';
import 'propose_attribute.dart';

class AcceptProposeAttributeRequestItemParametersWithNewAttribute extends AcceptProposeAttributeRequestItemParameters {
  final AbstractAttribute attribute;

  const AcceptProposeAttributeRequestItemParametersWithNewAttribute({required this.attribute});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'attribute': attribute.toJson()};
}
