import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'transfer_file_ownership_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class TransferFileOwnershipRequestItem extends RequestItemDerivation {
  final String fileReference;

  const TransferFileOwnershipRequestItem({
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.fileReference,
  }) : super(atType: 'TransferFileOwnershipRequestItem');

  factory TransferFileOwnershipRequestItem.fromJson(Map json) => _$TransferFileOwnershipRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$TransferFileOwnershipRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props, fileReference];
}
