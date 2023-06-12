import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';
import 'result.dart';

class AccountFacade {
  final AbstractEvaluator _evaluator;
  AccountFacade(this._evaluator);

  Future<Result<GetIdentityInfoResponse>> getIdentityInfo() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.getIdentityInfo()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => GetIdentityInfoResponse.fromJson(x));
  }

  Future<Result<DeviceDTO>> getDeviceInfo() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.getDeviceInfo()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => DeviceDTO.fromJson(x));
  }

  Future<void> registerPushNotificationToken({
    required String handle,
    required String installationId,
    required String platform,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.registerPushNotificationToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
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
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    result.throwOnError();
  }

  Future<Result<SyncEverythingResponse>> syncEverything() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.syncEverything({})
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => SyncEverythingResponse.fromJson(x));
  }

  Future<Result<SyncInfoResponse>> getSyncInfo() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.getSyncInfo()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => SyncInfoResponse.fromJson(x));
  }

  Future<void> enableAutoSync() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.enableAutoSync()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    result.throwOnError();
  }

  Future<void> disableAutoSync() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.disableAutoSync()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    result.throwOnError();
  }

  Future<Result<LoadItemFromTruncatedReferenceResponse>> loadItemFromTruncatedReference({
    required String reference,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.account.loadItemFromTruncatedReference(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'reference': reference,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LoadItemFromTruncatedReferenceResponse.fromJson(x));
  }
}
