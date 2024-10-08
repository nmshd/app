import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class DevicesFacade {
  final AbstractEvaluator _evaluator;
  DevicesFacade(this._evaluator);

  Future<Result<DeviceDTO>> getDevice(String deviceId) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.getDevice(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': deviceId,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeviceDTO.fromJson(value));
  }

  Future<Result<List<DeviceDTO>>> getDevices() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.getDevices()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<DeviceDTO>.from(value.map((e) => DeviceDTO.fromJson(e))));
  }

  Future<Result<DeviceDTO>> createDevice({String? name, String? description, bool? isAdmin}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.createDevice(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (isAdmin != null) 'isAdmin': isAdmin,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeviceDTO.fromJson(value));
  }

  Future<Result<DeviceSharedSecret>> getDeviceOnboardingInfo(String id, {String? profileName}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.getDeviceOnboardingInfo(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
          if (profileName != null) 'profileName': profileName,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeviceSharedSecret.fromJson(value));
  }

  Future<Result<TokenDTO>> getDeviceOnboardingToken(String id, {String? expiresAt, String? profileName}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.getDeviceOnboardingToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (profileName != null) 'profileName': profileName,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => TokenDTO.fromJson(value));
  }

  Future<Result<DeviceDTO>> updateDevice(String id, {String? name, String? description}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.updateDevice(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
          if (name != null) 'name': name,
          if (description != null) 'description': description,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeviceDTO.fromJson(value));
  }

  Future<VoidResult> deleteDevice(String deviceId) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.deleteDevice(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: null }''',
      arguments: {
        'request': {
          'id': deviceId,
        },
      },
    );

    final json = result.valueToMap();
    return VoidResult.fromJson(json);
  }

  Future<VoidResult> setCommunicationLanguage({required String communicationLanguage}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.devices.setCommunicationLanguage(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: null }''',
      arguments: {
        'request': {
          'communicationLanguage': communicationLanguage,
        },
      },
    );

    final json = result.valueToMap();
    return VoidResult.fromJson(json);
  }
}
