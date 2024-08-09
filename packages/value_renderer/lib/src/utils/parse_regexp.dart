RegExp parseRegExp(String pattern) {
  final hasStartingSlash = pattern.startsWith('/');
  final hasEndingSlash = pattern.endsWith('/');
  final hasFlag = pattern.endsWith('/i');

  var outputString = pattern;

  if (hasStartingSlash) outputString = outputString.substring(1);

  if (hasEndingSlash) {
    outputString = outputString.substring(0, outputString.length - 1);
  } else if (hasFlag) {
    outputString = outputString.substring(0, outputString.length - 2);
  }

  final bool isCaseSensitive = !hasFlag;

  return RegExp(outputString, caseSensitive: isCaseSensitive);
}
