import 'package:equatable/equatable.dart';

class ValueHintsValue extends Equatable {
  final dynamic key;
  final String displayName;

  const ValueHintsValue({
    required this.key,
    required this.displayName,
  });

  factory ValueHintsValue.fromJson(Map json) => ValueHintsValue(
        key: json['key'],
        displayName: json['displayName'],
      );

  Map<String, dynamic> toJson() => {
        '@type': 'ValueHintsValue',
        'key': key,
        'displayName': displayName,
      };

  @override
  String toString() => 'ValueHintsValue(key: $key, displayName: $displayName)';

  @override
  List<Object?> get props => [key, displayName];
}
