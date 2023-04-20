import 'identity_attribute_value.dart';

class Affiliation extends IdentityAttributeValue {
  final String role;
  final String organization;
  final String unit;

  const Affiliation({
    required this.role,
    required this.organization,
    required this.unit,
  });

  factory Affiliation.fromJson(Map json) => Affiliation(
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

  @override
  List<Object?> get props => [role, organization, unit];
}
