import 'propose_attribute.dart';

class AcceptProposeAttributeRequestItemParametersWithExistingAttribute extends AcceptProposeAttributeRequestItemParameters {
  final String attributeId;

  const AcceptProposeAttributeRequestItemParametersWithExistingAttribute({required this.attributeId});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'attributeId': attributeId};
}
