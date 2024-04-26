import 'identity_attribute_value.dart';

class AffiliationAttributeValue extends IdentityAttributeValue {
  final String role;
  final String organization;
  final String unit;

  const AffiliationAttributeValue({
    required this.role,
    required this.organization,
    required this.unit,
  }) : super('Affiliation');

  factory AffiliationAttributeValue.fromJson(Map json) => AffiliationAttributeValue(
        role: json['role'],
        organization: json['organization'],
        unit: json['unit'],
      );

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'role': role, 'organization': organization, 'unit': unit};

  @override
  List<Object?> get props => [role, organization, unit];
}
