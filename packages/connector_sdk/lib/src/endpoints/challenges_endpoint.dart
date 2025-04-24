import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';

class ChallengesEndpoint extends Endpoint {
  ChallengesEndpoint(super.dio);

  Future<ConnectorResponse<ChallengeDTO>> createChallenge(ChallengeType challengeType, [String? relationship]) => post(
    '/api/v2/Challenges',
    transformer: (v) => ChallengeDTO.fromJson(v),
    data: {'challengeType': challengeType.name, if (relationship != null) 'relationship': relationship},
  );

  Future<ConnectorResponse<ChallengeValidationResult>> validateChallenge(String challengeString, String signature) => post(
    '/api/v2/Challenges/Validate',
    transformer: (v) => ChallengeValidationResult.fromJson(v),
    data: {'challengeString': challengeString, 'signature': signature},
  );
}
