part of 'response_item.dart';

class AttributeSuccessionAcceptResponseItem extends AcceptResponseItem {
  final String predecessorId;
  final String successorId;
  final AbstractAttribute successorContent;

  const AttributeSuccessionAcceptResponseItem({
    required this.predecessorId,
    required this.successorId,
    required this.successorContent,
  });

  factory AttributeSuccessionAcceptResponseItem.fromJson(Map json) {
    return AttributeSuccessionAcceptResponseItem(
      predecessorId: json['predecessorId'],
      successorId: json['successorId'],
      successorContent: AbstractAttribute.fromJson(json['successorContent']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'AttributeSuccessionAcceptResponseItem',
        'predecessorId': predecessorId,
        'successorId': successorId,
        'successorContent': successorContent.toJson(),
      };

  @override
  List<Object?> get props => [super.props, predecessorId, successorId, successorContent];
}
