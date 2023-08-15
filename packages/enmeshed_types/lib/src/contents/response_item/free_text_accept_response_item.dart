part of 'response_item.dart';

class FreeTextAcceptResponseItem extends AcceptResponseItem {
  final String freeText;

  const FreeTextAcceptResponseItem({
    required this.freeText,
  });

  factory FreeTextAcceptResponseItem.fromJson(Map json) {
    return FreeTextAcceptResponseItem(
      freeText: json['freeText'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'FreeTextAcceptResponseItem',
        'freeText': freeText,
      };

  @override
  String toString() => 'FreeTextAcceptResponseItem(freeText: $freeText)';

  @override
  List<Object?> get props => [super.props, freeText];
}
