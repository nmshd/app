import 'identity_attribute_value.dart';

class FileReferenceAttributeValue extends IdentityAttributeValue {
  final String value;

  const FileReferenceAttributeValue({
    required this.value,
  });

  factory FileReferenceAttributeValue.fromJson(Map json) => FileReferenceAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'FileReference',
        'value': value,
      };

  @override
  String toString() => 'FileReferenceAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
