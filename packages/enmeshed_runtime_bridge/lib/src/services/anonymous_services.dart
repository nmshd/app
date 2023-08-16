import 'facades/abstract_evaluator.dart';
import 'facades/anonymous.dart';

class AnonymousServices {
  final AnonymousTokensFacade tokens;

  AnonymousServices(AbstractEvaluator evaluator) : tokens = AnonymousTokensFacade(evaluator);
}
