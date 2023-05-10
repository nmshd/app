import 'identity_attribute_value.dart';

class AffiliationOrganizationAttributeValue extends IdentityAttributeValue {
  final String value;

  const AffiliationOrganizationAttributeValue({
    required this.value,
  });

  factory AffiliationOrganizationAttributeValue.fromJson(Map json) => AffiliationOrganizationAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'AffiliationOrganization',
        'value': value,
      };

  @override
  String toString() => 'AffiliationOrganizationAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
