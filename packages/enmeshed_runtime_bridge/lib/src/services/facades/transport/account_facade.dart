import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

enum AccountFacadePushNotificationEnvironment {
  production._('Production'),
  development._('Development');

  final String name;

  const AccountFacadePushNotificationEnvironment._(this.name);
}

class AccountFacade {
  final AbstractEvaluator _evaluator;
  AccountFacade(this._evaluator);

  Future<Result<GetIdentityInfoResponse>> getIdentityInfo() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.getIdentityInfo()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => GetIdentityInfoResponse.fromJson(x));
  }

  Future<Result<DeviceDTO>> getDeviceInfo() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.getDeviceInfo()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => DeviceDTO.fromJson(x));
  }

  Future<Result<RegisterPushNotificationTokenResponse>> registerPushNotificationToken({
    required String handle,
    required String appId,
    required String platform,

    /// will only be used for iOS, defaults to 'production' if not provided
    required AccountFacadePushNotificationEnvironment? environment,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.account.registerPushNotificationToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'handle': handle, 'appId': appId, 'platform': platform, if (environment != null) 'environment': environment.name},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => RegisterPushNotificationTokenResponse.fromJson(x));
  }

  Future<VoidResult> unregisterPushNotificationToken() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.unregisterPushNotificationToken()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return VoidResult.fromJson(value);
  }

  Future<VoidResult> syncDatawallet() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.syncDatawallet({})
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return VoidResult.fromJson(value);
  }

  Future<Result<SyncEverythingResponse>> syncEverything() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.syncEverything({})
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => SyncEverythingResponse.fromJson(x));
  }

  Future<Result<SyncInfoResponse>> getSyncInfo() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.getSyncInfo()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => SyncInfoResponse.fromJson(x));
  }

  Future<VoidResult> enableAutoSync() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.enableAutoSync()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return VoidResult.fromJson(value);
  }

  Future<VoidResult> disableAutoSync() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.transportServices.account.disableAutoSync()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final value = result.valueToMap();
    return VoidResult.fromJson(value);
  }

  Future<Result<LoadItemFromReferenceResponse>> loadItemFromReference({required String reference, String? password}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.account.loadItemFromReference(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'reference': reference, if (password != null) 'password': password},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LoadItemFromReferenceResponse.fromJson(x));
  }
}
