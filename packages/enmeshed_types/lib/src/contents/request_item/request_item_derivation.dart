part of 'request_item.dart';

abstract class RequestItemDerivation extends RequestItem {
  final bool? requireManualDecision;

  const RequestItemDerivation({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    this.requireManualDecision,
  });

  factory RequestItemDerivation.fromJson(Map json) {
    final type = json['@type'];

    switch (type) {
      case 'ReadAttributeRequestItem':
        return ReadAttributeRequestItem.fromJson(json);
      case 'CreateAttributeRequestItem':
        return CreateAttributeRequestItem.fromJson(json);
      case 'ShareAttributeRequestItem':
        return ShareAttributeRequestItem.fromJson(json);
      case 'ProposeAttributeRequestItem':
        return ProposeAttributeRequestItem.fromJson(json);
      case 'ConsentRequestItem':
        return ConsentRequestItem.fromJson(json);
      case 'AuthenticationRequestItem':
        return AuthenticationRequestItem.fromJson(json);
      case 'RegisterAttributeListenerRequestItem':
        return RegisterAttributeListenerRequestItem.fromJson(json);
      case 'SucceedAttributeRequestItem':
        return SucceedAttributeRequestItem.fromJson(json);
      default:
        throw Exception('Unknown type: $type');
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        if (requireManualDecision != null) 'requireManualDecision': requireManualDecision,
      };

  @override
  String toString() => 'RequestItemDerivation(requireManualDecision: $requireManualDecision)';

  @override
  List<Object?> get props => [super.props, requireManualDecision];
}
