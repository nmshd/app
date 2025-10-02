import 'package:enmeshed_runtime_bridge/src/services/facades/utilities/runtime_error.dart';
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
        window.enmeshedFileSystem = parsedMap;
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
      const keyStorage = JSON.stringify(Array.from(window.enmeshedFileSystem));
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
      const keyStorage = JSON.stringify(Array.from(window.enmeshedFileSystem));
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
        const keyStorage = JSON.stringify(Array.from(window.enmeshedFileSystem));
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
      const keyStorage = JSON.stringify(Array.from(window.enmeshedFileSystem));
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
      const keyStorage = JSON.stringify(Array.from(window.enmeshedFileSystem));
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
      const keyStorage = JSON.stringify(Array.from(window.enmeshedFileSystem));
      return { value: result.value , keyStorage: keyStorage}''',
      arguments: {
        'request': {'jsonEncodedRequest': fetchedRequestJson},
      },
    );
    storeKeyStorageToPreferences(result.valueToMap()['keyStorage'].toString());
    return Result.success(result.valueToMap()['value']['status']);
  }

  Future<Result<List<VerifiableCredentialDTO>>> getAllStoredClaims() async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.getVerifiableCredentials(undefined)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'ids': 'undefined'},
      },
    );
    return Result.fromJson(
      result.valueToMap(),
      (x) => List<VerifiableCredentialDTO>.from((x as List).map((e) => VerifiableCredentialDTO.fromJson(e as Map<String, dynamic>))),
    );
  }

  Future<Result<VerifiableCredentialDTO>> getStoredClaimWithId(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const result = await session.consumptionServices.openId4Vc.getVerifiableCredentials(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': [id],
      },
    );
    if (result.valueToMap().isEmpty || result.valueToMap()['value'] == null || (result.valueToMap()['value'] as List).isEmpty) {
      return Result.failure(RuntimeError(message: 'No stored claim found', code: '400'));
    }
    if ((result.valueToMap()['value'] as List).length > 1) {
      return Result.failure(RuntimeError(message: 'Multiple stored claims found', code: '400'));
    }
    final claim = VerifiableCredentialDTO.fromJson((result.valueToMap()['value'] as List).first);
    return Result.success(claim);
  }
}
