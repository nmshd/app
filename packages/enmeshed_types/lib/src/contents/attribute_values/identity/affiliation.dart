import 'identity_attriube_value.dart';

class Affiliation extends IdentityAttributeValue {
  final String role;
  final String organization;
  final String unit;
  Affiliation({
    required this.role,
    required this.organization,
    required this.unit,
  });

  factory Affiliation.fromJson(Map<String, dynamic> json) => Affiliation(
        role: json['role'],
        organization: json['organization'],
        unit: json['unit'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Affiliation',
        'role': role,
        'organization': organization,
        'unit': unit,
      };

  @override
  String toString() => 'Affiliation(role: $role, organization: $organization, unit: $unit)';
}
