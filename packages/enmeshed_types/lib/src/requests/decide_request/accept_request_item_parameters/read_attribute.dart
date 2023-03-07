part of '../decide_request.dart';

abstract class AcceptReadAttributeRequestItemParameters extends AcceptRequestItemParameters {}

class AcceptReadAttributeRequestItemParametersWithExistingAttribute extends AcceptRequestItemParameters {
  final String existingAttributeId;

  AcceptReadAttributeRequestItemParametersWithExistingAttribute({required this.existingAttributeId});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'existingAttributeId': existingAttributeId};
}

class AcceptReadAttributeRequestItemParametersWithNewAttribute extends AcceptRequestItemParameters {
  final AbstractAttribute newAttribute;

  AcceptReadAttributeRequestItemParametersWithNewAttribute({required this.newAttribute});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'newAttribute': newAttribute.toJson()};
}
