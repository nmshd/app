RegExp parseRegExp(String pattern) {
  final bool hasSlashes = pattern.startsWith('/') || pattern.endsWith('/');
  final bool hasFlag = pattern.endsWith('/i');

  final String parsedPattern = pattern
      .substring(
        hasSlashes ? 1 : 0,
        hasFlag ? pattern.length - 2 : pattern.length,
      )
      .replaceAll('/', '');

  final bool isCaseSensitive = !hasFlag;

  return RegExp(parsedPattern, caseSensitive: isCaseSensitive);
}
