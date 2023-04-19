import 'identity_attribute_value.dart';

class State extends IdentityAttributeValue {
  final String value;

  const State({
    required this.value,
  });

  factory State.fromJson(Map json) => State(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'State',
        'value': value,
      };

  @override
  String toString() => 'State(value: $value)';

  @override
  List<Object?> get props => [value];
}
