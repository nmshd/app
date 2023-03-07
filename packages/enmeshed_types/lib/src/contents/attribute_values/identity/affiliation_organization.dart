import 'identity_attriube_value.dart';

class AffiliationOrganization extends IdentityAttributeValue {
  final String value;
  AffiliationOrganization({
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
}
