import 'identity_attribute_value.dart';

class Website extends IdentityAttributeValue {
  final String value;

  const Website({
    required this.value,
  });

  factory Website.fromJson(Map<String, dynamic> json) => Website(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Website',
        'value': value,
      };

  @override
  String toString() => 'Website(value: $value)';

  @override
  List<Object?> get props => [value];
}
