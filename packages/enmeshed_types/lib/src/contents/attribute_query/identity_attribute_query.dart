part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
class IdentityAttributeQuery extends AttributeQuery {
  final String valueType;
  final List<String>? tags;

  const IdentityAttributeQuery({
    required this.valueType,
    this.tags,
    super.validFrom,
    super.validTo,
  });

  factory IdentityAttributeQuery.fromJson(Map json) => _$IdentityAttributeQueryFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {'@type': 'IdentityAttributeQuery', ..._$IdentityAttributeQueryToJson(this)};

  @override
  List<Object?> get props => [
        super.props,
        valueType,
        tags,
      ];
}
