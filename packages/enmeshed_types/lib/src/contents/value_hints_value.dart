class ValueHintsValue {
  final dynamic key;
  final String displayName;

  ValueHintsValue({
    required this.key,
    required this.displayName,
  });

  factory ValueHintsValue.fromJson(Map<String, dynamic> json) => ValueHintsValue(
        key: json['key'],
        displayName: json['displayName'],
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'displayName': displayName,
      };

  @override
  String toString() => 'ValueHintsValue(key: $key, displayName: $displayName)';
}
