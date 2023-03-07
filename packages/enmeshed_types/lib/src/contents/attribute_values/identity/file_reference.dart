import 'identity_attriube_value.dart';

class FileReference extends IdentityAttributeValue {
  final String value;

  FileReference({
    required this.value,
  });

  factory FileReference.fromJson(Map<String, dynamic> json) => FileReference(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'FileReference',
        'value': value,
      };

  @override
  String toString() => 'FileReference(value: $value)';
}
