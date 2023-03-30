import 'identity_attribute_value.dart';

class AffiliationUnit extends IdentityAttributeValue {
  final String value;

  const AffiliationUnit({
    required this.value,
  });

  factory AffiliationUnit.fromJson(Map<String, dynamic> json) => AffiliationUnit(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'AffiliationUnit',
        'value': value,
      };

  @override
  String toString() => 'AffiliationUnit(value: $value)';

  @override
  List<Object?> get props => [value];
}
