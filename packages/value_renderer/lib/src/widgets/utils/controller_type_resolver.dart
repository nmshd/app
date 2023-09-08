import 'package:enmeshed_types/enmeshed_types.dart';

class ControllerTypeResolver {
  static dynamic resolveType({required dynamic value, required RenderHintsTechnicalType type}) {
    switch (type) {
      case RenderHintsTechnicalType.Boolean:
        return value.toBool();
      case RenderHintsTechnicalType.Float:
        return value.toDouble();
      case RenderHintsTechnicalType.Integer:
        return value.toInt();
      case RenderHintsTechnicalType.String:
        return value.toString();
      //TODO: Define a proper default value
      default:
        return value.toString();
    }
  }
}
