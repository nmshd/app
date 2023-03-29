import 'identity_attribute_value.dart';

class AffiliationOrganization extends IdentityAttributeValue {
  final String value;

  const AffiliationOrganization({
    required this.value,
  });

  factory AffiliationOrganization.fromJson(Map<String, dynamic> json) => AffiliationOrganization(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'AffiliationOrganization',
        'value': value,
      };

  @override
  String toString() => 'AffiliationOrganization(value: $value)';

  @override
  List<Object?> get props => [value];
}
