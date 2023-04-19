import 'identity_attribute_value.dart';

class EMailAddress extends IdentityAttributeValue {
  final String value;

  const EMailAddress({
    required this.value,
  });

  factory EMailAddress.fromJson(Map json) => EMailAddress(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'EMailAddress',
        'value': value,
      };

  @override
  String toString() => 'EMailAddress(value: $value)';

  @override
  List<Object?> get props => [value];
}
