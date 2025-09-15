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
      const result = await session.consumptionServices.openId4Vc.resolveCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'credentialOfferUrl': url},
      },
    );
    print('VerifiableCredentialDTO data: ${result.valueToMap()['value']['data']}');
    return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
  }

  Future<Result<String>> fetchCredentialOffer(String url) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.fetchCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'credentialOfferUrl': url},
      },
    );
    print(result.valueToMap());
    return Result.success(result.valueToMap()['value']['jsonRepresentation'] as String? ?? 'ERROR');
  }

  Future<Result<VerifiableCredentialDTO>> acceptFetchedCredentialOffer(String fetchedOfferJson, String? pinCode) async {
    if (pinCode == null) {
      final result = await _evaluator.evaluateJavaScript(
        '''
        const result = await session.consumptionServices.openId4Vc.resolveFetchedCredentialOffer(request)
        if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
        return { value: result.value }''',
        arguments: {
          'request': {'data': fetchedOfferJson},
        },
      );
      return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
    }

    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.resolveFetchedCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'data': fetchedOfferJson, 'pinCode': pinCode},
      },
    );
    return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
  }
}
