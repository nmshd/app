import 'abstract_attribute.dart';
import 'attribute_values/attribute_values.dart';

class IdentityAttribute extends AbstractAttribute {
  final IdentityAttributeValue value;
  final List<String>? tags;

  const IdentityAttribute({required super.owner, super.validFrom, super.validTo, required this.value, this.tags});

  factory IdentityAttribute.fromJson(Map json) => IdentityAttribute(
    owner: json['owner'],
    validFrom: json['validFrom'],
    validTo: json['validTo'],
    value: IdentityAttributeValue.fromJson(json['value']),
    tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
  );

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'IdentityAttribute', 'value': value.toJson(), if (tags != null) 'tags': tags};

  @override
  List<Object?> get props => [...super.props, value, tags];
}
