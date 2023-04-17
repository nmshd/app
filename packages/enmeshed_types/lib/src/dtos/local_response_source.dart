import 'package:equatable/equatable.dart';

class LocalResponseSourceDTO extends Equatable {
  final String type;
  final String reference;

  const LocalResponseSourceDTO({
    required this.type,
    required this.reference,
  });

  factory LocalResponseSourceDTO.fromJson(Map<String, dynamic> json) {
    return LocalResponseSourceDTO(
      type: json['type'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'reference': reference,
      };

  @override
  String toString() => 'LocalResponseSourceDTO(type: $type, reference: $reference)';

  @override
  List<Object?> get props => [type, reference];
}
