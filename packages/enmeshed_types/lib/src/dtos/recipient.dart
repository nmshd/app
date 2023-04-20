import 'package:equatable/equatable.dart';

class RecipientDTO extends Equatable {
  final String address;
  final String? receivedAt;
  final String? receivedByDevice;
  final String relationshipId;

  const RecipientDTO({
    required this.address,
    this.receivedAt,
    this.receivedByDevice,
    required this.relationshipId,
  });

  factory RecipientDTO.fromJson(Map json) => RecipientDTO(
        address: json['address'],
        receivedAt: json['receivedAt'],
        receivedByDevice: json['receivedByDevice'],
        relationshipId: json['relationshipId'],
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        if (receivedAt != null) 'receivedAt': receivedAt,
        if (receivedByDevice != null) 'receivedByDevice': receivedByDevice,
        'relationshipId': relationshipId,
      };

  @override
  String toString() {
    return 'RecipientDTO { address: $address, receivedAt: $receivedAt, receivedByDevice: $receivedByDevice, relationshipId: $relationshipId }';
  }

  @override
  List<Object?> get props => [address, receivedAt, receivedByDevice, relationshipId];
}
