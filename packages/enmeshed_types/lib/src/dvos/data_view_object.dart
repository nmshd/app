import 'common/common.dart';

class DataViewObject {
  String id;
  String name;
  String? description;
  String? image;
  String type;
  String? date;
  DVOError? error;
  DVOWarning? warning;

  DataViewObject({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.type,
    this.date,
    this.error,
    this.warning,
  });
}
