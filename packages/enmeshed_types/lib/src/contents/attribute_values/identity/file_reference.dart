import 'identity_attribute_value.dart';

class FileReference extends IdentityAttributeValue {
  final String value;

  const FileReference({
    required this.value,
  });

  factory FileReference.fromJson(Map json) => FileReference(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'FileReference',
        'value': value,
      };

  @override
  String toString() => 'FileReference(value: $value)';

  @override
  List<Object?> get props => [value];
}
