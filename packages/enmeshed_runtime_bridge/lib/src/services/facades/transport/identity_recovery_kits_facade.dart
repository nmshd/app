import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class IdentityRecoveryKitsFacade {
  final AbstractEvaluator _evaluator;
  IdentityRecoveryKitsFacade(this._evaluator);

  Future<Result<TokenDTO>> createIdentityRecoveryKit({required String profileName, required PasswordProtection passwordProtection}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityRecoveryKits.createIdentityRecoveryKit(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'profileName': profileName,
          'passwordProtection': passwordProtection.toJson(),
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<({bool exists})>> checkForExistingIdentityRecoveryKit() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identityRecoveryKits.checkForExistingIdentityRecoveryKit()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => (exists: x['exists'] as bool));
  }
}
