import 'decide_request_parameters_item.dart';

class DecideRequestParameters {
  final String requestId;
  final List<DecideRequestParametersItem> items;

  const DecideRequestParameters({required this.requestId, required this.items});

  Map<String, dynamic> toJson() {
    return {'requestId': requestId, 'items': items.map((item) => item.toJson()).toList()};
  }
}
