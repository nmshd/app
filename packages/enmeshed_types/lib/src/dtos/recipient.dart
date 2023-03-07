class RecipientDTO {
  final String address;
  final String? receivedAt;
  final String? receivedByDevice;
  final String relationshipId;

  RecipientDTO({
    required this.address,
    required this.receivedAt,
    required this.receivedByDevice,
    required this.relationshipId,
  });

  factory RecipientDTO.fromJson(Map<String, dynamic> json) => RecipientDTO(
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
}
