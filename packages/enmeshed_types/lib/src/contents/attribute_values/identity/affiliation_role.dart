import 'identity_attribute_value.dart';

class AffiliationRoleAttributeValue extends IdentityAttributeValue {
  final String value;

  const AffiliationRoleAttributeValue({
    required this.value,
  });

  factory AffiliationRoleAttributeValue.fromJson(Map json) => AffiliationRoleAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'AffiliationRole',
        'value': value,
      };

  @override
  String toString() => 'AffiliationRoleAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
