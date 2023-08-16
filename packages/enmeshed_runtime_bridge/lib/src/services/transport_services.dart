import 'facades/abstract_evaluator.dart';
import 'facades/transport.dart';

class TransportServices {
  final MessagesFacade _messages;
  MessagesFacade get messages => _messages;

  final RelationshipsFacade _relationships;
  RelationshipsFacade get relationships => _relationships;

  final RelationshipTemplatesFacade _relationshipTemplates;
  RelationshipTemplatesFacade get relationshipTemplates => _relationshipTemplates;

  final FilesFacade _files;
  FilesFacade get files => _files;

  final AccountFacade _account;
  AccountFacade get account => _account;

  final TokensFacade _tokens;
  TokensFacade get tokens => _tokens;

  final DevicesFacade _devices;
  DevicesFacade get devices => _devices;

  TransportServices(AbstractEvaluator evaluator)
      : _messages = MessagesFacade(evaluator),
        _relationships = RelationshipsFacade(evaluator),
        _relationshipTemplates = RelationshipTemplatesFacade(evaluator),
        _files = FilesFacade(evaluator),
        _account = AccountFacade(evaluator),
        _tokens = TokensFacade(evaluator),
        _devices = DevicesFacade(evaluator);
}
