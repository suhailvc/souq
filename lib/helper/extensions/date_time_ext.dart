import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String format12HHMMA() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('hh:mm a').format(_getLocalDate()).toString();
    }
  }

  String formatDDMMMMYYYY({final String separator = ','}) {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd MMMM${separator}yyyy')
          .format(_getLocalDate())
          .toString();
    }
  }

  String formatYYYYMMDD() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('yyyy-MM-dd').format(_getLocalDate()).toString();
    }
  }

  String formatDDMMYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd/MM/yy').format(_getLocalDate()).toString();
    }
  }

  String formatDDMMYYYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd/MM/yyyy').format(_getLocalDate()).toString();
    }
  }

  String format24HHMM() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('HH:mm').format(_getLocalDate()).toString();
    }
  }

  DateTime clearHMS() {
    if (this == null) {
      final DateTime now = DateTime.now();
      return DateTime(now.year, now.month, now.day, 0, 0, 0);
    } else {
      return DateTime(_getLocalDate().year, _getLocalDate().month,
          _getLocalDate().day, 0, 0, 0);
    }
  }

  String formatDDMMMYYYY({final String separator = ','}) {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd MMM$separator yyyy')
          .format(_getLocalDate())
          .toString();
    }
  }

  String formatMMMYYYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('MMM, yyyy').format(_getLocalDate()).toString();
    }
  }

  String formatYYYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('yyyy').format(_getLocalDate()).toString();
    }
  }

  String? dateTimeVariable() {
    if (this == null) {
      return null;
    }
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

    final DateTime dateToCheck = _getLocalDate();
    final DateTime aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return 'Today'.tr;
    } else if (aDate == yesterday) {
      return 'Yesterday'.tr;
    } else if (aDate == tomorrow) {
      return 'Tomorrow'.tr;
    }

    return null;
  }

  DateTime _getLocalDate() {
    return this!.toUtc().toLocal();
  }
}
