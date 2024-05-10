import 'facades/abstract_evaluator.dart';
import 'facades/transport.dart';

class TransportServices {
  final MessagesFacade messages;
  final RelationshipsFacade relationships;
  final RelationshipTemplatesFacade relationshipTemplates;
  final FilesFacade files;
  final AccountFacade account;
  final TokensFacade tokens;
  final DevicesFacade devices;
  final IdentityFacade identity;
  final IdentityDeletionProcessesFacade identityDeletionProcesses;

  TransportServices(AbstractEvaluator evaluator)
      : messages = MessagesFacade(evaluator),
        relationships = RelationshipsFacade(evaluator),
        relationshipTemplates = RelationshipTemplatesFacade(evaluator),
        files = FilesFacade(evaluator),
        account = AccountFacade(evaluator),
        tokens = TokensFacade(evaluator),
        devices = DevicesFacade(evaluator),
        identity = IdentityFacade(evaluator),
        identityDeletionProcesses = IdentityDeletionProcessesFacade(evaluator);
}
