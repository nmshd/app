import 'identity_attribute_value.dart';

class IdentityFileReferenceAttributeValue extends IdentityAttributeValue {
  final String value;

  const IdentityFileReferenceAttributeValue({
    required this.value,
  });

  factory IdentityFileReferenceAttributeValue.fromJson(Map json) => IdentityFileReferenceAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'IdentityFileReference',
        'value': value,
      };

  @override
  String toString() => 'IdentityFileReferenceAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
