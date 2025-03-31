import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'free_text_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class FreeTextAcceptResponseItem extends AcceptResponseItem {
  final String freeText;

  const FreeTextAcceptResponseItem({required this.freeText});

  factory FreeTextAcceptResponseItem.fromJson(Map json) => _$FreeTextAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), ..._$FreeTextAcceptResponseItemToJson(this), '@type': 'FreeTextAcceptResponseItem'};

  @override
  List<Object?> get props => [super.props, freeText];
}
