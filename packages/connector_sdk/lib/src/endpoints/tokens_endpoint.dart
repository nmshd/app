import 'package:connector_sdk/src/endpoints/transformers.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';

class TokensEndpoint extends Endpoint {
  TokensEndpoint(super.dio);

  Future<ConnectorResponse<TokenDTO>> getToken(String tokenId) => get('/api/v2/Tokens/$tokenId', transformer: tokenTransformer);

  Future<ConnectorResponse<List<int>>> getQrCodeForToken(String tokenId) => downloadQrCode('GET', '/api/v2/Tokens/$tokenId');
  Future<ConnectorResponse<List<TokenDTO>>> getOwnTokens([Map<String, dynamic>? query]) => get(
        '/api/v2/Tokens/Own',
        query: query,
        transformer: tokenListTransformer,
      );

  Future<ConnectorResponse<TokenDTO>> createOwnToken({required String expiresAt, required Map<String, dynamic> content, bool? ephemeral}) => post(
        '/api/v2/Tokens/Own',
        data: {
          'expiresAt': expiresAt,
          'content': content,
          'ephemeral': ephemeral,
        },
        transformer: tokenTransformer,
      );

  Future<ConnectorResponse<List<TokenDTO>>> getPeerTokens([Map<String, dynamic>? query]) => get(
        '/api/v2/Tokens/Peer',
        query: query,
        transformer: tokenListTransformer,
      );

  Future<ConnectorResponse<TokenDTO>> loadPeerTokenByTruncatedReference({required String reference, bool? ephemeral}) => post(
        '/api/v2/Tokens/Peer',
        data: {
          'reference': reference,
          'ephemeral': ephemeral,
        },
        transformer: tokenTransformer,
      );

  Future<ConnectorResponse<TokenDTO>> loadPeerTokenByIdAndKey({required String id, required String secretKey, bool? ephemeral}) => post(
        '/api/v2/Tokens/Peer',
        data: {
          'id': id,
          'secretKey': secretKey,
          'ephemeral': ephemeral,
        },
        transformer: tokenTransformer,
      );
}
