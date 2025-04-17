import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'form_field_accept_response_item.g.dart';

sealed class FormFieldAcceptResponseType {
  const FormFieldAcceptResponseType();

  factory FormFieldAcceptResponseType.fromJson(dynamic json) => switch (json) {
    String() => FormFieldStringResponse(json),
    num() => FormFieldNumResponse(json),
    bool() => FormFieldBoolResponse(json),
    List<String>() => FormFieldStringListResponse(json),
    _ => throw Exception('Invalid type for FormFieldAcceptResponseType: ${json.runtimeType}'),
  };

  dynamic toJson();
}

class FormFieldStringResponse implements FormFieldAcceptResponseType {
  final String value;

  const FormFieldStringResponse(this.value);

  @override
  String toJson() => value;
}

class FormFieldNumResponse implements FormFieldAcceptResponseType {
  final num value;

  const FormFieldNumResponse(this.value);

  @override
  num toJson() => value;
}

class FormFieldBoolResponse implements FormFieldAcceptResponseType {
  final bool value;

  const FormFieldBoolResponse(this.value);

  @override
  bool toJson() => value;
}

class FormFieldStringListResponse implements FormFieldAcceptResponseType {
  final List<String> value;

  const FormFieldStringListResponse(this.value);

  @override
  List<String> toJson() => value;
}

@JsonSerializable(includeIfNull: false)
class FormFieldAcceptResponseItem extends AcceptResponseItem {
  final FormFieldAcceptResponseType response;

  const FormFieldAcceptResponseItem({required this.response}) : super(atType: 'FormFieldAcceptResponseItem');

  factory FormFieldAcceptResponseItem.fromJson(Map json) => _$FormFieldAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [...super.props, response];
}
