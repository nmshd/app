import 'identity_attribute_value.dart';

class AffiliationRole extends IdentityAttributeValue {
  final String value;

  const AffiliationRole({
    required this.value,
  });

  factory AffiliationRole.fromJson(Map<String, dynamic> json) => AffiliationRole(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'AffiliationRole',
        'value': value,
      };

  @override
  String toString() => 'AffiliationRole(value: $value)';

  @override
  List<Object?> get props => [value];
}
