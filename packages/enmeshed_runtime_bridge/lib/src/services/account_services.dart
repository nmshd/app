import 'package:enmeshed_types/enmeshed_types.dart';

import 'facades/abstract_evaluator.dart';
import 'facades/handle_call_async_js_result.dart';

class AccountServices {
  final AbstractEvaluator _evaluator;

  AccountServices(this._evaluator);

  Future<LocalAccountDTO> createAccount({
    realm = 'id1',
    required String name,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.createAccount(realm, name)',
      arguments: {
        'realm': realm,
        'name': name,
      },
    );

    final value = result.valueToMap();
    final account = LocalAccountDTO.fromJson(value);
    return account;
  }

  Future<LocalAccountDTO> onboardAccount(DeviceSharedSecret onboardingInfo) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.onboardAccount(onboardingInfo)',
      arguments: {'onboardingInfo': onboardingInfo.toJson()},
    );

    final value = result.valueToMap();
    final account = LocalAccountDTO.fromJson(value);
    return account;
  }

  Future<List<LocalAccountDTO>> getAccounts() async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.getAccounts()',
    );

    final value = result.valueToList();
    final accounts = value.map((e) => LocalAccountDTO.fromJson(e)).toList();
    return accounts;
  }

  Future<void> clearAccounts() async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.clearAccounts()',
    );

    result.throwOnError();
  }

  Future<void> renameAccount({
    required String localAccountId,
    required String newAccountName,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.renameAccount(localAccountId, newAccountName)',
      arguments: {
        'localAccountId': localAccountId,
        'newAccountName': newAccountName,
      },
    );

    result.throwOnError();
  }
}
