import '../../../contents/abstract_attribute.dart';
import 'accept_request_item_parameters.dart';

abstract class AcceptReadAttributeRequestItemParameters extends AcceptRequestItemParameters {}

class AcceptReadAttributeRequestItemParametersWithExistingAttribute extends AcceptRequestItemParameters {
  final String existingAttributeId;
  final List<String>? tags;

  const AcceptReadAttributeRequestItemParametersWithExistingAttribute({required this.existingAttributeId, this.tags});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'existingAttributeId': existingAttributeId, if (tags != null) 'tags': tags};
}

class AcceptReadAttributeRequestItemParametersWithNewAttribute extends AcceptRequestItemParameters {
  final AbstractAttribute newAttribute;

  const AcceptReadAttributeRequestItemParametersWithNewAttribute({required this.newAttribute});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'newAttribute': newAttribute.toJson()};
}
