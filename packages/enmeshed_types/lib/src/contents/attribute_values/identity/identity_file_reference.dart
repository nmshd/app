import 'identity_attribute_value.dart';

class IdentityFileReferenceAttributeValue extends IdentityAttributeValue {
  final String value;

  const IdentityFileReferenceAttributeValue({
    required this.value,
  }) : super('IdentityFileReference');

  factory IdentityFileReferenceAttributeValue.fromJson(Map json) => IdentityFileReferenceAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  List<Object?> get props => [value];
}
