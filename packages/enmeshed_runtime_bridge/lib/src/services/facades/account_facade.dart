import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class AccountFacade {
  final AbstractEvaluator _evaluator;
  AccountFacade(this._evaluator);

  Future<GetIdentityInfoResponse> getIdentityInfo() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.getIdentityInfo()
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    final value = result.toValue<Map<String, dynamic>>();
    final response = GetIdentityInfoResponse.fromJson(value);
    return response;
  }

  Future<DeviceDTO> getDeviceInfo() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.getDeviceInfo()
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    final value = result.toValue<Map<String, dynamic>>();
    final device = DeviceDTO.fromJson(value);
    return device;
  }

  Future<void> registerPushNotificationToken({
    required String handle,
    required String installationId,
    required String platform,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.registerPushNotificationToken(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'handle': handle,
          'installationId': installationId,
          'platform': platform,
        },
      },
    );

    result.throwOnError();
  }

  Future<void> syncDatawallet() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.syncDatawallet({})
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    result.throwOnError();
  }

  Future<SyncEverythingResponse> syncEverything() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.syncEverything({})
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    final value = result.toValue<Map<String, dynamic>>();
    final response = SyncEverythingResponse.fromJson(value);
    return response;
  }

  Future<SyncInfoResponse> getSyncInfo() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.getSyncInfo()
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    final value = result.toValue<Map<String, dynamic>>();
    final syncInfo = SyncInfoResponse.fromJson(value);
    return syncInfo;
  }

  Future<void> enableAutoSync() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.enableAutoSync()
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    result.throwOnError();
  }

  Future<void> disableAutoSync() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.disableAutoSync()
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    result.throwOnError();
  }

  Future<LoadItemFromTruncatedReferenceResponse> loadItemFromTruncatedReference({
    required String reference,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.loadItemFromTruncatedReference(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'reference': reference,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final response = LoadItemFromTruncatedReferenceResponse.fromJson(value);
    return response;
  }
}
