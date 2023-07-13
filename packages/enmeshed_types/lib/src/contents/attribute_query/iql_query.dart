part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
class IQLQuery extends AttributeQuery {
  final String queryString;

  const IQLQuery({
    super.validFrom,
    super.validTo,
    required this.queryString,
  });

  factory IQLQuery.fromJson(Map json) => _$IQLQueryFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {'@type': 'IQLQuery', ..._$IQLQueryToJson(this)};
}
