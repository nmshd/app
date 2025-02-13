part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
class IQLQueryCreationHints extends Equatable {
  final String valueType;
  final List<String>? tags;

  const IQLQueryCreationHints({required this.valueType, this.tags});

  factory IQLQueryCreationHints.fromJson(Map json) => _$IQLQueryCreationHintsFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$IQLQueryCreationHintsToJson(this);

  @override
  List<Object?> get props => [valueType, tags];
}
