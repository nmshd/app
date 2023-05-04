import 'identity_attribute_value.dart';

class WebsiteAttributeValue extends IdentityAttributeValue {
  final String value;

  const WebsiteAttributeValue({
    required this.value,
  });

  factory WebsiteAttributeValue.fromJson(Map json) => WebsiteAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Website',
        'value': value,
      };

  @override
  String toString() => 'WebsiteAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
