import 'decide_request_item_parameters.dart';

class RejectRequestItemParameters implements DecideRequestItemParameters {
  final String? code;
  final String? message;

  const RejectRequestItemParameters({this.code, this.message});

  @override
  Map<String, dynamic> toJson() => {
        'accept': false,
        if (code != null) 'code': code,
        if (message != null) 'message': message,
      };
}
