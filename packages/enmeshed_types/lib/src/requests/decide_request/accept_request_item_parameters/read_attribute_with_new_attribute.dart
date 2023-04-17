import '../../../contents/abstract_attribute.dart';
import '../accept_request_item_parameters.dart';

class AcceptReadAttributeRequestItemParametersWithNewAttribute extends AcceptRequestItemParameters {
  final AbstractAttribute newAttribute;

  const AcceptReadAttributeRequestItemParametersWithNewAttribute({required this.newAttribute});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'newAttribute': newAttribute.toJson()};
}
