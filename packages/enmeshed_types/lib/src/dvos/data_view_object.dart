import 'common/common.dart';

class DataViewObject {
  String id;
  String? name;
  String? description;
  String? image;
  String type;
  String? date;
  dynamic items;
  DVOError? error;
  DVOWarning? warning;

  DataViewObject({
    required this.id,
    this.name,
    this.description,
    this.image,
    required this.type,
    this.date,
    this.items,
    this.error,
    this.warning,
  });

  factory DataViewObject.fromJson(Map json) => DataViewObject(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        type: json['type'],
        date: json['date'],
        items: json['items'],
        error: json['error'] != null ? DVOError.fromJson(json['error']) : null,
        warning: json['warning'] != null ? DVOWarning.fromJson(json['warning']) : null,
      );
}
