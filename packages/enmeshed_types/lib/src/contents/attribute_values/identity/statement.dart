import 'identity_attribute_value.dart';

// TODO properly implement this

class StatementAttributeValue extends IdentityAttributeValue {
  final Map json;

  const StatementAttributeValue({required this.json}) : super('Statement');

  factory StatementAttributeValue.fromJson(Map json) => StatementAttributeValue(json: json);

  @override
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(json);

  @override
  List<Object?> get props => [json];
}
