import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class SettingsFacade {
  final AbstractEvaluator _evaluator;
  SettingsFacade(this._evaluator);

  Future<Result<SettingDTO>> createSetting({
    required String key,
    required Map<String, dynamic> value,
    String? reference,
    SettingScope? scope,
    String? succeedsAt,
    String? succeedsItem,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.createSetting(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'key': key,
          'value': value,
          if (reference != null) 'reference': reference,
          if (scope != null) 'scope': scope.toString().split('.').last,
          if (succeedsAt != null) 'succeedsAt': succeedsAt,
          if (succeedsItem != null) 'succeedsItem': succeedsItem,
        },
      },
    );

    return Result.fromJson(result.valueToMap(), (x) => SettingDTO.fromJson(x));
  }

  Future<Result<SettingDTO>> getSetting(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.getSetting(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': id},
      },
    );

    return Result.fromJson(result.valueToMap(), (x) => SettingDTO.fromJson(x));
  }

  Future<Result<SettingDTO>> getSettingByKey(String key, {String? reference, SettingScope? scope}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.getSettingByKey(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'key': key, if (reference != null) 'reference': reference, if (scope != null) 'scope': scope.name},
      },
    );

    return Result.fromJson(result.valueToMap(), (x) => SettingDTO.fromJson(x));
  }

  Future<Result<List<SettingDTO>>> getSettings({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.getSettings(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {if (query != null) 'query': query.toJson()},
      },
    );

    return Result.fromJson(result.valueToMap(), (value) => List<SettingDTO>.from(value.map((e) => SettingDTO.fromJson(e))));
  }

  Future<VoidResult> deleteSetting(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.deleteSetting(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: null }''',
      arguments: {
        'request': {'id': id},
      },
    );

    final value = result.valueToMap();
    return VoidResult.fromJson(value);
  }

  Future<Result<SettingDTO>> updateSetting(String id, Map<String, dynamic> value) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.updateSetting(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': id, 'value': value},
      },
    );

    return Result.fromJson(result.valueToMap(), (x) => SettingDTO.fromJson(x));
  }

  Future<Result<SettingDTO>> upsertSettingByKey(String key, Map<String, dynamic> value, {String? reference, SettingScope? scope}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.settings.upsertSettingByKey(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'key': key, 'value': value, if (reference != null) 'reference': reference, if (scope != null) 'scope': scope.name},
      },
    );

    return Result.fromJson(result.valueToMap(), (x) => SettingDTO.fromJson(x));
  }
}
