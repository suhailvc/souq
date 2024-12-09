import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:intl/intl.dart';

extension StringExt on String? {
  bool isNotNullAndEmpty() {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  int countWord() {
    if (this == null) {
      return 0;
    }
    final Iterable<RegExpMatch> matches =
        RegexHelper.regexCountWord.allMatches(this ?? '');
    return matches.length;
  }

  DateTime formatHHMMSS() {
    if (this == null) {
      return DateTime.now();
    }
    final DateFormat dateFormat = DateFormat('HH:mm:ss');
    return dateFormat.parse(this!);
  }

  DateTime formatMMDDYYYY() {
    if (this == null) {
      return DateTime.now();
    }
    final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    return dateFormat.parse(this!);
  }

  DateTime formatDDMMYYYY() {
    if (this == null) {
      return DateTime.now();
    }
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.parse(this!);
  }

  String removeLastCharacter() {
    if (this == null) {
      return '';
    }
    if (this!.isNotEmpty) {
      return this!.substring(0, this!.length - 1);
    }
    return this!; // Return the original string if it's empty
  }

  double? toDouble() {
    if (this != null) {
      return double.tryParse(this!);
    }
    return 0.0;
  }
}
