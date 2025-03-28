import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

// TODO: why doesn't this work?
// part 'free_text_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class FreeTextAcceptResponseItem extends AcceptResponseItem {
  final String freeText;

  const FreeTextAcceptResponseItem({required this.freeText});

  factory FreeTextAcceptResponseItem.fromJson(Map json) {
    return FreeTextAcceptResponseItem(freeText: json['freeText']);
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'FreeTextAcceptResponseItem', 'freeText': freeText};

  @override
  List<Object?> get props => [super.props, freeText];
}
