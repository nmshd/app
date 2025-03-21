part of 'request_item.dart';

class TransferFileOwnershipRequestItem extends RequestItemDerivation {
  final String fileReference;

  const TransferFileOwnershipRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.fileReference,
  });

  factory TransferFileOwnershipRequestItem.fromJson(Map json) {
    return TransferFileOwnershipRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      fileReference: json['fileReference'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'TransferFileOwnershipRequestItem', 'fileReference': fileReference};

  @override
  List<Object?> get props => [super.props, fileReference];
}
