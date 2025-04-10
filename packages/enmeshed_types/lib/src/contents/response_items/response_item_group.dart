import 'package:json_annotation/json_annotation.dart';

import 'response_item.dart';
import 'response_item_derivation.dart';

part 'response_item_group.g.dart';

@JsonSerializable(includeIfNull: false)
class ResponseItemGroup extends ResponseItem {
  final List<ResponseItemDerivation> items;

  const ResponseItemGroup({required this.items}) : super(atType: 'ResponseItemGroup');

  factory ResponseItemGroup.fromJson(Map json) => _$ResponseItemGroupFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ResponseItemGroupToJson(this);

  @override
  List<Object?> get props => [items];
}
