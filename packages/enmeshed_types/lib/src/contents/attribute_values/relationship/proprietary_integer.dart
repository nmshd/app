import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryIntegerAttributeValue extends ProprietaryAttributeValueAttributeValue {
  final int value;

  const ProprietaryIntegerAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryIntegerAttributeValue.fromJson(Map json) => ProprietaryIntegerAttributeValue(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryInteger',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryIntegerAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
