import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'form_field_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
sealed class FormFieldAcceptResponseType {
  const FormFieldAcceptResponseType();

  factory FormFieldAcceptResponseType.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'FormFieldStringResponse' => FormFieldStringResponse.fromJson(json),
      'FormFieldNumResponse' => FormFieldNumResponse.fromJson(json),
      'FormFieldBoolResponse' => FormFieldBoolResponse.fromJson(json),
      'FormFieldStringListResponse' => FormFieldStringListResponse.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  Map<String, dynamic> toJson();

  List<Object?> get props => [];
}

@JsonSerializable(includeIfNull: false)
class FormFieldStringResponse extends FormFieldAcceptResponseType {
  final String value;

  const FormFieldStringResponse({required this.value}) : super();

  factory FormFieldStringResponse.fromJson(Map json) => _$FormFieldStringResponseFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldStringResponseToJson(this);

  @override
  List<Object?> get props => [...super.props, value];
}

@JsonSerializable(includeIfNull: false)
class FormFieldNumResponse extends FormFieldAcceptResponseType {
  final num value;

  const FormFieldNumResponse({required this.value}) : super();

  factory FormFieldNumResponse.fromJson(Map json) => _$FormFieldNumResponseFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldNumResponseToJson(this);

  @override
  List<Object?> get props => [...super.props, value];
}

@JsonSerializable(includeIfNull: false)
class FormFieldBoolResponse extends FormFieldAcceptResponseType {
  final bool value;

  const FormFieldBoolResponse({required this.value}) : super();

  factory FormFieldBoolResponse.fromJson(Map json) => _$FormFieldBoolResponseFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldBoolResponseToJson(this);

  @override
  List<Object?> get props => [...super.props, value];
}

@JsonSerializable(includeIfNull: false)
class FormFieldStringListResponse extends FormFieldAcceptResponseType {
  final List<String> value;

  const FormFieldStringListResponse({required this.value}) : super();

  factory FormFieldStringListResponse.fromJson(Map json) => _$FormFieldStringListResponseFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldStringListResponseToJson(this);

  @override
  List<Object?> get props => [...super.props, value];
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
