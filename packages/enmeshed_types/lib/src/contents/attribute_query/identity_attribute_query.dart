part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
class IdentityAttributeQuery extends AttributeQuery {
  final String valueType;
  final List<String>? tags;
  final String? validFrom;
  final String? validTo;

  const IdentityAttributeQuery({required this.valueType, this.tags, this.validFrom, this.validTo});

  factory IdentityAttributeQuery.fromJson(Map json) => _$IdentityAttributeQueryFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {'@type': 'IdentityAttributeQuery', ..._$IdentityAttributeQueryToJson(this)};

  @override
  List<Object?> get props => [super.props, valueType, tags];
}
