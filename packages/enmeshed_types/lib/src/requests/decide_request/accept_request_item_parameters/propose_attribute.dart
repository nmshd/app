part of '../decide_request.dart';

abstract class AcceptProposeAttributeRequestItemParameters extends AcceptRequestItemParameters {}

class AcceptProposeAttributeRequestItemParametersWithNewAttribute extends AcceptProposeAttributeRequestItemParameters {
  final AbstractAttribute attribute;

  AcceptProposeAttributeRequestItemParametersWithNewAttribute({required this.attribute});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'attribute': attribute.toJson()};
}

class AcceptProposeAttributeRequestItemParametersWithExistingAttribute extends AcceptProposeAttributeRequestItemParameters {
  final String attributeId;

  AcceptProposeAttributeRequestItemParametersWithExistingAttribute({required this.attributeId});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'attributeId': attributeId};
}
