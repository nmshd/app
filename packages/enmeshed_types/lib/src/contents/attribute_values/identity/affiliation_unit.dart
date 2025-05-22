import 'identity_attribute_value.dart';

class AffiliationUnitAttributeValue extends IdentityAttributeValue {
  final String value;

  const AffiliationUnitAttributeValue({required this.value}) : super('AffiliationUnit');

  factory AffiliationUnitAttributeValue.fromJson(Map json) => AffiliationUnitAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
