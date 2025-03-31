import 'package:json_annotation/json_annotation.dart';

import 'response_item.dart';
import 'response_item_derivation.dart';

part 'reject_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class RejectResponseItem extends ResponseItemDerivation {
  final String? code;
  final String? message;

  const RejectResponseItem({this.code, this.message}) : super(result: ResponseItemResult.Rejected);

  factory RejectResponseItem.fromJson(Map json) => _$RejectResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), ..._$RejectResponseItemToJson(this), '@type': 'RejectResponseItem'};

  @override
  List<Object?> get props => [super.props, code, message];
}
