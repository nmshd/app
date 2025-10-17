import 'facades/abstract_evaluator.dart';
import 'facades/consumption.dart';

class ConsumptionServices {
  final AttributesFacade attributes;
  final IncomingRequestsFacade incomingRequests;
  final OutgoingRequestsFacade outgoingRequests;
  final SettingsFacade settings;

  ConsumptionServices(AbstractEvaluator evaluator)
    : attributes = AttributesFacade(evaluator),
      incomingRequests = IncomingRequestsFacade(evaluator),
      outgoingRequests = OutgoingRequestsFacade(evaluator),
      settings = SettingsFacade(evaluator);
}
