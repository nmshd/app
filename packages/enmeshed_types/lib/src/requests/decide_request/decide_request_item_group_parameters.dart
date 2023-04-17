import 'decide_request_item_parameters.dart';
import 'decide_request_parameters_item.dart';

class DecideRequestItemGroupParameters extends DecideRequestParametersItem {
  final List<DecideRequestItemParameters> items;

  const DecideRequestItemGroupParameters({required this.items});

  @override
  Map<String, dynamic> toJson() => {'items': List<dynamic>.from(items.map((x) => x.toJson()))};
}
