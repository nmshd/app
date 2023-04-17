import '../../../contents/abstract_attribute.dart';
import 'accept_request_item_parameters.dart';

abstract class AcceptReadAttributeRequestItemParameters extends AcceptRequestItemParameters {}

class AcceptReadAttributeRequestItemParametersWithNewAttribute extends AcceptRequestItemParameters {
  final AbstractAttribute newAttribute;

  const AcceptReadAttributeRequestItemParametersWithNewAttribute({required this.newAttribute});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'newAttribute': newAttribute.toJson()};
}

class AcceptReadAttributeRequestItemParametersWithExistingAttribute extends AcceptRequestItemParameters {
  final String existingAttributeId;

  const AcceptReadAttributeRequestItemParametersWithExistingAttribute({required this.existingAttributeId});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'existingAttributeId': existingAttributeId};
}
