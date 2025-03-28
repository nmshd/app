import 'accept_request_item_parameters.dart';

class AcceptFreeTextRequestItemParameters extends AcceptRequestItemParameters {
  final String freeText;

  const AcceptFreeTextRequestItemParameters({required this.freeText});

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'freeText': freeText};
}
