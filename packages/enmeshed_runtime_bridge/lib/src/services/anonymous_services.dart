import 'facades/abstract_evaluator.dart';
import 'facades/anonymous.dart';

class AnonymousServices {
  final AnonymousTokensFacade tokens;
  final BackboneCompatibilityFacade backboneCompatibility;

  AnonymousServices(AbstractEvaluator evaluator)
      : tokens = AnonymousTokensFacade(evaluator),
        backboneCompatibility = BackboneCompatibilityFacade(evaluator);
}
