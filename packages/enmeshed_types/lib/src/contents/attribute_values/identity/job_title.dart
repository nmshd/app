import 'identity_attribute_value.dart';

class JobTitle extends IdentityAttributeValue {
  final String value;

  const JobTitle({
    required this.value,
  });

  factory JobTitle.fromJson(Map<String, dynamic> json) => JobTitle(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'JobTitle',
        'value': value,
      };

  @override
  String toString() => 'JobTitle(value: $value)';

  @override
  List<Object?> get props => [value];
}
