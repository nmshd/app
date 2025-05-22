import '../../../contents/contents.dart';
import 'accept_request_item_parameters.dart';

class AcceptFormFieldRequestItemParameters extends AcceptRequestItemParameters {
  final FormFieldAcceptResponseType response;

  const AcceptFormFieldRequestItemParameters({required this.response});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'response': response};
}
