import 'package:enmeshed_types/enmeshed_types.dart';

import 'facades/abstract_evaluator.dart';
import 'facades/handle_call_async_js_result.dart';

class AccountServices {
  final AbstractEvaluator _evaluator;

  AccountServices(this._evaluator);

  Future<LocalAccountDTO> createAccount({required String name}) async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.createAccount(name)', arguments: {'name': name});

    final value = result.valueToMap();
    final account = LocalAccountDTO.fromJson(value);
    return account;
  }

  Future<LocalAccountDTO> onboardAccount(DeviceSharedSecret onboardingInfo, {String? name}) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.onboardAccount(onboardingInfo, name ?? undefined)',
      arguments: {'onboardingInfo': onboardingInfo.toJson(), 'name': ?name},
    );

    final value = result.valueToMap();
    final account = LocalAccountDTO.fromJson(value);
    return account;
  }

  Future<List<LocalAccountDTO>> getAccounts() async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.getAccounts()');

    final value = result.valueToList();
    final accounts = value.map((e) => LocalAccountDTO.fromJson(e)).toList();
    return accounts;
  }

  Future<List<LocalAccountDTO>> getAccountsInDeletion() async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.getAccountsInDeletion()');

    final value = result.valueToList();
    final accounts = value.map((e) => LocalAccountDTO.fromJson(e)).toList();
    return accounts;
  }

  Future<List<LocalAccountDTO>> getAccountsNotInDeletion() async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.getAccountsNotInDeletion()');

    final value = result.valueToList();
    final accounts = value.map((e) => LocalAccountDTO.fromJson(e)).toList();
    return accounts;
  }

  Future<LocalAccountDTO> getAccount(String id) async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.getAccount(id)', arguments: {'id': id});

    final value = result.valueToMap();
    final account = LocalAccountDTO.fromJson(value);
    return account;
  }

  Future<void> offboardAccount(String id) async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.offboardAccount(id)', arguments: {'id': id});

    result.throwOnError();
  }

  Future<void> deleteAccount(String id) async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.deleteAccount(id)', arguments: {'id': id});

    result.throwOnError();
  }

  Future<void> clearAccounts() async {
    final result = await _evaluator.evaluateJavaScript('return await runtime.accountServices.clearAccounts()');

    result.throwOnError();
  }

  Future<void> renameAccount({required String localAccountId, required String newAccountName}) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await runtime.accountServices.renameAccount(localAccountId, newAccountName)',
      arguments: {'localAccountId': localAccountId, 'newAccountName': newAccountName},
    );

    result.throwOnError();
  }
}
