import 'facades/abstract_evaluator.dart';
import 'facades/consumption.dart';

class ConsumptionServices {
  final AttributesFacade _attributes;
  AttributesFacade get attributes => _attributes;

  final AttributeListenersFacade _attributeListeners;
  AttributeListenersFacade get attributeListeners => _attributeListeners;

  final IncomingRequestsFacade _incomingRequests;
  IncomingRequestsFacade get incomingRequests => _incomingRequests;

  final OutgoingRequestsFacade _outgoingRequests;
  OutgoingRequestsFacade get outgoingRequests => _outgoingRequests;

  ConsumptionServices(AbstractEvaluator evaluator)
      : _attributes = AttributesFacade(evaluator),
        _attributeListeners = AttributeListenersFacade(evaluator),
        _incomingRequests = IncomingRequestsFacade(evaluator),
        _outgoingRequests = OutgoingRequestsFacade(evaluator);
}
