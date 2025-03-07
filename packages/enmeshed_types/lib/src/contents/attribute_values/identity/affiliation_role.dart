import 'identity_attribute_value.dart';

class AffiliationRoleAttributeValue extends IdentityAttributeValue {
  final String value;

  const AffiliationRoleAttributeValue({required this.value}) : super('AffiliationRole');

  factory AffiliationRoleAttributeValue.fromJson(Map json) => AffiliationRoleAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
