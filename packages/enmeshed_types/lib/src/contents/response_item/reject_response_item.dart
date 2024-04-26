part of 'response_item.dart';

class RejectResponseItem extends ResponseItemDerivation {
  final String? code;
  final String? message;

  const RejectResponseItem({
    this.code,
    this.message,
  }) : super(result: ResponseItemResult.Rejected);

  factory RejectResponseItem.fromJson(Map json) {
    return RejectResponseItem(
      code: json['code'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'RejectResponseItem',
        if (code != null) 'code': code,
        if (message != null) 'message': message,
      };

  @override
  List<Object?> get props => [super.props, code, message];
}
