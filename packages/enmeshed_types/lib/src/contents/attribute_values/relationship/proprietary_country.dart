import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryCountry extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryCountry({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryCountry.fromJson(Map json) => ProprietaryCountry(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryCountry',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryCountry(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
