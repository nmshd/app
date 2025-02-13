import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class IdentityDeletionProcessesFacade {
  final AbstractEvaluator _evaluator;
  IdentityDeletionProcessesFacade(this._evaluator);

  Future<Result<IdentityDeletionProcessDTO>> approveIdentityDeletionProcess() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.approveIdentityDeletionProcess()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => IdentityDeletionProcessDTO.fromJson(x));
  }

  Future<Result<IdentityDeletionProcessDTO>> rejectIdentityDeletionProcess() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.rejectIdentityDeletionProcess()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => IdentityDeletionProcessDTO.fromJson(x));
  }

  Future<Result<IdentityDeletionProcessDTO>> initiateIdentityDeletionProcess({double? lengthOfGracePeriodInDays}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {if (lengthOfGracePeriodInDays != null) 'lengthOfGracePeriodInDays': lengthOfGracePeriodInDays},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => IdentityDeletionProcessDTO.fromJson(x));
  }

  Future<Result<IdentityDeletionProcessDTO>> cancelIdentityDeletionProcess() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.cancelIdentityDeletionProcess()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => IdentityDeletionProcessDTO.fromJson(x));
  }

  Future<Result<IdentityDeletionProcessDTO>> getIdentityDeletionProcess(String identityDeletionProcessId) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.getIdentityDeletionProcess(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': identityDeletionProcessId},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => IdentityDeletionProcessDTO.fromJson(x));
  }

  Future<Result<List<IdentityDeletionProcessDTO>>> getIdentityDeletionProcesses() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.getIdentityDeletionProcesses()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<IdentityDeletionProcessDTO>.from(value.map((x) => IdentityDeletionProcessDTO.fromJson(x))));
  }

  Future<Result<IdentityDeletionProcessDTO>> getActiveIdentityDeletionProcess() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityDeletionProcesses.getActiveIdentityDeletionProcess()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => IdentityDeletionProcessDTO.fromJson(x));
  }
}
