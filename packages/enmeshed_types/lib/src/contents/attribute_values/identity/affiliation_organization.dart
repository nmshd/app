import 'identity_attribute_value.dart';

class AffiliationOrganizationAttributeValue extends IdentityAttributeValue {
  final String value;

  const AffiliationOrganizationAttributeValue({
    required this.value,
  }) : super('AffiliationOrganization');

  factory AffiliationOrganizationAttributeValue.fromJson(Map json) => AffiliationOrganizationAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
