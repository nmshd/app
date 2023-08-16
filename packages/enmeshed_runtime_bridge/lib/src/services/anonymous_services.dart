import 'facades/abstract_evaluator.dart';
import 'facades/anonymous.dart';

class AnonymousServices {
  final AnonymousTokensFacade _tokens;
  AnonymousTokensFacade get tokens => _tokens;

  AnonymousServices(AbstractEvaluator evaluator) : _tokens = AnonymousTokensFacade(evaluator);
}
