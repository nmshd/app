import 'package:equatable/equatable.dart';

enum LocalRequestSourceType { Message, RelationshipTemplate }

class LocalRequestSourceDTO extends Equatable {
  final LocalRequestSourceType type;
  final String reference;

  const LocalRequestSourceDTO({
    required this.type,
    required this.reference,
  });

  factory LocalRequestSourceDTO.fromJson(Map json) {
    return LocalRequestSourceDTO(
      type: LocalRequestSourceType.values.byName(json['type']),
      reference: json['reference'],
    );
  }

  static LocalRequestSourceDTO? fromJsonNullable(Map? json) => json != null ? LocalRequestSourceDTO.fromJson(json) : null;

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'reference': reference,
      };

  @override
  List<Object?> get props => [type, reference];
}
