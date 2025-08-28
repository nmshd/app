import 'facades/abstract_evaluator.dart';
import 'facades/consumption.dart';

class ConsumptionServices {
  final AttributesFacade attributes;
  final AttributeListenersFacade attributeListeners;
  final IncomingRequestsFacade incomingRequests;
  final OutgoingRequestsFacade outgoingRequests;
  final SettingsFacade settings;
  final OpenId4VcFacade openId4Vc;

  ConsumptionServices(AbstractEvaluator evaluator)
    : attributes = AttributesFacade(evaluator),
      attributeListeners = AttributeListenersFacade(evaluator),
      incomingRequests = IncomingRequestsFacade(evaluator),
      outgoingRequests = OutgoingRequestsFacade(evaluator),
      settings = SettingsFacade(evaluator),
      openId4Vc = OpenId4VcFacade(evaluator);
}
