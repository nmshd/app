import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryHEXColor extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryHEXColor({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryHEXColor.fromJson(Map json) => ProprietaryHEXColor(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryHEXColor',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryHEXColor(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
