import 'accept_request_item_parameters.dart';

class AcceptDeleteAttributeRequestItemParameters extends AcceptRequestItemParameters {
  final String deletionDate;

  const AcceptDeleteAttributeRequestItemParameters({required this.deletionDate});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'deletionDate': deletionDate};
}
