import 'package:meta/meta.dart';

import '../../contents/contents.dart';

part 'accept_request_item_parameters/propose_attribute.dart';
part 'accept_request_item_parameters/read_attribute.dart';

class DecideRequestParameters {
  final String requestId;
  final List<DecideRequestParametersItem> items;

  const DecideRequestParameters({
    required this.requestId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

abstract class DecideRequestParametersItem {
  const DecideRequestParametersItem();
  Map<String, dynamic> toJson();
}

abstract class DecideRequestItemParameters extends DecideRequestParametersItem {
  const DecideRequestItemParameters();
}

class DecideRequestItemGroupParameters extends DecideRequestParametersItem {
  final List<DecideRequestItemParameters> items;

  const DecideRequestItemGroupParameters({required this.items});

  @override
  Map<String, dynamic> toJson() => {'items': List<dynamic>.from(items.map((x) => x.toJson()))};
}

class AcceptRequestItemParameters extends DecideRequestItemParameters {
  const AcceptRequestItemParameters();
  @override
  @mustCallSuper
  Map<String, dynamic> toJson() => {'accept': true};
}

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
