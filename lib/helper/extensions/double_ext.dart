import 'dart:math';

extension TruncateDoubles on double {
  double truncateToDecimalPlaces(final int fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}
