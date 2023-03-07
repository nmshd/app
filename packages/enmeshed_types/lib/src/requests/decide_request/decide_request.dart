import 'package:meta/meta.dart';

import '../../contents/contents.dart';

part 'accept_request_item_parameters/propose_attribute.dart';
part 'accept_request_item_parameters/read_attribute.dart';

class DecideRequestParameters {
  final String requestId;
  final List<DecideRequestParametersItem> items;

  DecideRequestParameters({
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
  DecideRequestParametersItem();
  Map<String, dynamic> toJson();
}

abstract class DecideRequestItemParameters extends DecideRequestParametersItem {
  DecideRequestItemParameters();
}

class DecideRequestItemGroupParameters extends DecideRequestParametersItem {
  List<DecideRequestItemParameters> items;

  DecideRequestItemGroupParameters({required this.items});

  @override
  Map<String, dynamic> toJson() => {'items': List<dynamic>.from(items.map((x) => x.toJson()))};
}

class AcceptRequestItemParameters extends DecideRequestItemParameters {
  @override
  @mustCallSuper
  Map<String, dynamic> toJson() => {'accept': true};
}

class RejectRequestItemParameters implements DecideRequestItemParameters {
  final String? code;
  final String? message;

  RejectRequestItemParameters({this.code, this.message});

  @override
  Map<String, dynamic> toJson() => {
        'accept': false,
        if (code != null) 'code': code,
        if (message != null) 'message': message,
      };
}
