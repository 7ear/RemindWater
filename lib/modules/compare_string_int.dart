bool compareNumbers(dynamic number, String stringNumber) {
  String cleaned = stringNumber
    .replaceAll(' ', '')
    .replaceAll(',', '.');

  double? parsed = double.tryParse(cleaned);
  if (parsed == null) return false;

  if (number is int) {
    return parsed > number.toDouble();
  } else if (number is double) {
    return parsed > number;
  }
  return false;
}