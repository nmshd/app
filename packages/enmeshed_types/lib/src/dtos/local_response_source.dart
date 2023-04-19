import 'package:equatable/equatable.dart';

enum LocalResponseSourceType { Message, RelationshipChange }

class LocalResponseSourceDTO extends Equatable {
  final LocalResponseSourceType type;
  final String reference;

  const LocalResponseSourceDTO({
    required this.type,
    required this.reference,
  });

  factory LocalResponseSourceDTO.fromJson(Map json) {
    return LocalResponseSourceDTO(
      type: LocalResponseSourceType.values.byName(json['type']),
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'reference': reference,
      };

  @override
  String toString() => 'LocalResponseSourceDTO(type: $type, reference: $reference)';

  @override
  List<Object?> get props => [type, reference];
}
