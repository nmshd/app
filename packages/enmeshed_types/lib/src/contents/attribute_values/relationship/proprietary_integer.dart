import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryInteger extends ProprietaryAttributeValue {
  final int value;

  const ProprietaryInteger({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryInteger.fromJson(Map<String, dynamic> json) => ProprietaryInteger(
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
  String toString() => 'ProprietaryInteger(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
