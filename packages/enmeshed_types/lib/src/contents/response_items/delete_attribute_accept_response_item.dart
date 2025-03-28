import 'accept_response_item.dart';

class DeleteAttributeAcceptResponseItem extends AcceptResponseItem {
  final String deletionDate;

  const DeleteAttributeAcceptResponseItem({required this.deletionDate});

  factory DeleteAttributeAcceptResponseItem.fromJson(Map json) {
    return DeleteAttributeAcceptResponseItem(deletionDate: json['deletionDate']);
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'DeleteAttributeAcceptResponseItem', 'deletionDate': deletionDate};

  @override
  String toString() => 'DeleteAttributeAcceptResponseItem(deletionDate: $deletionDate)';

  @override
  List<Object?> get props => [super.props, deletionDate];
}
