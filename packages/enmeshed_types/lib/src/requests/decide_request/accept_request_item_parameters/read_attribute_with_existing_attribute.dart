import '../accept_request_item_parameters.dart';

class AcceptReadAttributeRequestItemParametersWithExistingAttribute extends AcceptRequestItemParameters {
  final String existingAttributeId;

  const AcceptReadAttributeRequestItemParametersWithExistingAttribute({required this.existingAttributeId});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'existingAttributeId': existingAttributeId};
}
