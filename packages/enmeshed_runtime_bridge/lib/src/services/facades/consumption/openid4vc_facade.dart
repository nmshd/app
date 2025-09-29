import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

/*
  Note: The keystore is managed within the apps preferences. This is a temporary solution, but this should
  be replaced by a more secure solution before leaving the alpha stage.

  To do so the keystore is stored and loaded from the SharedPreferences upon each facade call.
*/

class OpenId4VcFacade {
  final AbstractEvaluator _evaluator;

  OpenId4VcFacade(this._evaluator);

  Future<void> loadKeyStorageFromPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    final keyStore = preferences.getString('keyStore');
    if (keyStore != null) {
      await _evaluator.evaluateJavaScript(
        '''
        const parsedMap = new Map(JSON.parse(keyStore));
        window.fakeKeyStorage = parsedMap;
        ''',
        arguments: {'keyStore': keyStore},
      );
    }
  }

  Future<void> storeKeyStorageToPreferences(String jsonEncodedKeyStorage) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('keyStore', jsonEncodedKeyStorage);
  }

  Future<Result<VerifiableCredentialDTO>> acceptCredentialOffer(String url) async {
    await loadKeyStorageFromPreferences();
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.resolveCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      const keyStorage = JSON.stringify(Array.from(window.fakeKeyStorage));
      return { value: result.value , keyStorage: keyStorage}''',
      arguments: {
        'request': {'credentialOfferUrl': url},
      },
    );
    storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
    return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
  }

  Future<Result<String>> fetchCredentialOffer(String url) async {
    await loadKeyStorageFromPreferences();
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.fetchCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      const keyStorage = JSON.stringify(Array.from(window.fakeKeyStorage));
      return { value: result.value , keyStorage: keyStorage}''',
      arguments: {
        'request': {'credentialOfferUrl': url},
      },
    );
    storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
    return Result.success(result.valueToMap()['value']['jsonRepresentation'] as String? ?? 'ERROR');
  }

  Future<Result<VerifiableCredentialDTO>> acceptFetchedCredentialOffer(
    String fetchedOfferJson,
    String? pinCode,
    List<String> requestedCredentials,
  ) async {
    await loadKeyStorageFromPreferences();
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
      storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
      return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
    }

    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.resolveFetchedCredentialOffer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      const keyStorage = JSON.stringify(Array.from(window.fakeKeyStorage));
      return { value: result.value , keyStorage: keyStorage}''',
      arguments: {
        'request': {'data': fetchedOfferJson, 'pinCode': pinCode, 'requestedCredentials': requestedCredentials},
      },
    );
    storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
    return Result.fromJson(result.valueToMap(), (x) => VerifiableCredentialDTO.fromJson(x));
  }

  Future<Result<String>> fetchPresentationRequest(String url) async {
    await loadKeyStorageFromPreferences();
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.fetchProofRequest(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      const keyStorage = JSON.stringify(Array.from(window.fakeKeyStorage));
      return { value: result.value , keyStorage: keyStorage}''',
      arguments: {
        'request': {'proofRequestUrl': url},
      },
    );
    storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
    return Result.success(result.valueToMap()['value']['jsonRepresentation'] as String? ?? 'ERROR');
  }

  Future<Result<int>> acceptFetchedCredentialPresentation(String fetchedRequestJson) async {
    await loadKeyStorageFromPreferences();
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.acceptProofRequest(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      const keyStorage = JSON.stringify(Array.from(window.fakeKeyStorage));
      return { value: result.value , keyStorage: keyStorage}''',
      arguments: {
        'request': {'jsonEncodedRequest': fetchedRequestJson},
      },
    );
    storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
    return Result.success(result.valueToMap()['value']['status']);
  }
}
