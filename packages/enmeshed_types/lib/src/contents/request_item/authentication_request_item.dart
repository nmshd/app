part of 'request_item.dart';

class AuthenticationRequestItem extends RequestItemDerivation {
  const AuthenticationRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
  });

  factory AuthenticationRequestItem.fromJson(Map json) {
    return AuthenticationRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'],
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'AuthenticationRequestItem',
      };

  @override
  List<Object?> get props => [super.props];
}
