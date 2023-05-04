import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryStringAttributeValue extends ProprietaryAttributeValueAttributeValue {
  final String value;

  const ProprietaryStringAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryStringAttributeValue.fromJson(Map json) => ProprietaryStringAttributeValue(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryString',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryStringAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
