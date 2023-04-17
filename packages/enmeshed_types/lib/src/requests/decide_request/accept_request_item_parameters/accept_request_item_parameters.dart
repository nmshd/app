import 'package:meta/meta.dart';

import '../decide_request_item_parameters.dart';

class AcceptRequestItemParameters extends DecideRequestItemParameters {
  const AcceptRequestItemParameters();

  @override
  @mustCallSuper
  Map<String, dynamic> toJson() => {'accept': true};
}
