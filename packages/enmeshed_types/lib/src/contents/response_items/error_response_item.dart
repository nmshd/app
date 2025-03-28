import 'package:json_annotation/json_annotation.dart';

import 'response_item.dart';
import 'response_item_derivation.dart';

part 'error_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ErrorResponseItem extends ResponseItemDerivation {
  final String code;
  final String message;

  const ErrorResponseItem({required this.code, required this.message}) : super(result: ResponseItemResult.Error);

  factory ErrorResponseItem.fromJson(Map json) => _$ErrorResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$ErrorResponseItemToJson(this));
    json['@type'] = 'ErrorResponseItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props, code, message];
}
