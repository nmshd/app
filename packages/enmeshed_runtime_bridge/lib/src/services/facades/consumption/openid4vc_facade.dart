import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Result<VerifiableCredentialDTO>> acceptFetchedCredentialOffer(
    String fetchedOfferJson,
    String? pinCode,
    List<String> requestedCredentials,
  ) async {
    if (pinCode == null) {
      final result = await _evaluator.evaluateJavaScript(
        '''
        const result = await session.consumptionServices.openId4Vc.resolveFetchedCredentialOffer(request)
        if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
        const keyStorage = JSON.stringify(Array.from(window.fakeKeyStorage));
        return { value: result.value , keyStorage: keyStorage}''',
        arguments: {
          'request': {'data': fetchedOfferJson, 'requestedCredentials': requestedCredentials},
        },
      );
      //--------------- START HACK PART 1- NEVER DO THIS IN PRODUCTION ----------
      // before returning we will store the key storage within the bounds of the app
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('keyStore', result.valueToMap()['keyStorage'].toString());
      //-------------- END HACK -------------------
      return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
    }

    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.resolveFetchedCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'data': fetchedOfferJson, 'pinCode': pinCode, 'requestedCredentials': requestedCredentials},
      },
    );
    return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
  }

  Future<Result<String>> fetchPresentationRequest(String url) async {
    // --------------- START HACK PART 2 - NEVER DO THIS IN PRODUCTION ----------
    // before fetching the presentation request we will restore the key storage to the javascript environment
    final preferences = await SharedPreferences.getInstance();
    final keyStore = preferences.getString('keyStore');
    if (keyStore != null) {
      await _evaluator.evaluateJavaScript(
        '''
        const parsedMap = new Map(JSON.parse(keyStore));
        console.log('Restored key storage: ', JSON.stringify(Array.from(parsedMap)));
        window.fakeKeyStorage = parsedMap;
        ''',
        arguments: {'keyStore': keyStore},
      );
      print('Restored key storage from app storage to JS environment.');
    }

    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.fetchProofRequest(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'proofRequestUrl': url},
      },
    );
    return Result.success(result.valueToMap()['value']['jsonRepresentation'] as String? ?? 'ERROR');
  }

  Future<Result<int>> acceptFetchedCredentialPresentation(String fetchedRequestJson) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.acceptProofRequest(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'jsonEncodedRequest': fetchedRequestJson},
      },
    );
    return Result.success(result.valueToMap()['value']['status']);
  }
}
