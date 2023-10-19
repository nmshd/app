import 'identity_attribute_value.dart';

class JobTitleAttributeValue extends IdentityAttributeValue {
  final String value;

  const JobTitleAttributeValue({
    required this.value,
  }) : super('JobTitle');

  factory JobTitleAttributeValue.fromJson(Map json) => JobTitleAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'JobTitleAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
