import 'package:equatable/equatable.dart';

class LocalRequestSourceDTO extends Equatable {
  final String type;
  final String reference;

  const LocalRequestSourceDTO({
    required this.type,
    required this.reference,
  });

  factory LocalRequestSourceDTO.fromJson(Map json) {
    return LocalRequestSourceDTO(
      type: json['type'],
      reference: json['reference'],
    );
  }

  static LocalRequestSourceDTO? fromJsonNullable(Map? json) => json != null ? LocalRequestSourceDTO.fromJson(json) : null;

  Map<String, dynamic> toJson() => {
        'type': type,
        'reference': reference,
      };

  @override
  String toString() => 'LocalRequestSourceDTO(type: $type, reference: $reference)';

  @override
  List<Object?> get props => [type, reference];
}
