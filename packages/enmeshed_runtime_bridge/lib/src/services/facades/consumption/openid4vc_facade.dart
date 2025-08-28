import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class OpenId4VcFacade {
  final AbstractEvaluator _evaluator;

  OpenId4VcFacade(this._evaluator);

  Future<Result<VerifiableCredentialDTO>> acceptCredentialOffer(String url) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.settings.non_existent()
      return { debug: result }
      const custom_msg = 'Test123'
      if (result.isError) return { error: { message: custom_msg, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'credentialOfferUrl': url},
      },
    );

    return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
  }
}
