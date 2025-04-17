import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'form_field_accept_response_item.g.dart';

sealed class FormFieldAcceptResponseTypes {}

class StringResponse extends FormFieldAcceptResponseTypes {
  final String value;
  StringResponse(this.value);
}

class BoolResponse extends FormFieldAcceptResponseTypes {
  final bool value;
  BoolResponse(this.value);
}

class NumResponse extends FormFieldAcceptResponseTypes {
  final num value;
  NumResponse(this.value);
}

class StringListResponse extends FormFieldAcceptResponseTypes {
  final List<String> value;
  StringListResponse(this.value);
}

@JsonSerializable(includeIfNull: false)
class FormFieldAcceptResponseItem extends AcceptResponseItem {
  final FormFieldAcceptResponseTypes response;

  const FormFieldAcceptResponseItem({required this.response}) : super(atType: 'FormFieldAcceptResponseItem');

  factory FormFieldAcceptResponseItem.fromJson(Map json) => _$FormFieldAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [...super.props, response];
}
