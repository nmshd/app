import 'response_item.dart';
import 'response_item_derivation.dart';

class ErrorResponseItem extends ResponseItemDerivation {
  final String code;
  final String message;

  const ErrorResponseItem({required this.code, required this.message}) : super(result: ResponseItemResult.Error);

  factory ErrorResponseItem.fromJson(Map json) {
    return ErrorResponseItem(code: json['code'], message: json['message']);
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'ErrorResponseItem', 'code': code, 'message': message};

  @override
  List<Object?> get props => [super.props, code, message];
}
