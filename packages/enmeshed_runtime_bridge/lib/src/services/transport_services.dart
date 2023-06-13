import 'facades/facades.dart';

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

  TransportServices(AbstractEvaluator evaluator)
      : _messages = MessagesFacade(evaluator),
        _relationships = RelationshipsFacade(evaluator),
        _relationshipTemplates = RelationshipTemplatesFacade(evaluator),
        _files = FilesFacade(evaluator),
        _account = AccountFacade(evaluator);
}
