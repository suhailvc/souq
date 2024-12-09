import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';

class OrderStatsReqModel {
  OrderStatsReqModel({this.startDate, this.strSelectedDate, this.endDate});
  DateTime? startDate;
  DateTime? endDate;
  String? strSelectedDate;

  void manageSelectedDates(
      {final DateTime? startDate, final DateTime? endDate}) {
    this.startDate = startDate.clearHMS();
    this.endDate = endDate.clearHMS();
    if (startDate != null && endDate != null) {
      // get date range to show from_date-to_date
      final String stringRange =
          '${startDate.formatDDMMMYYYY(separator: '')} - ${endDate.formatDDMMMYYYY(separator: '')}';

      if (this.startDate!.isBefore(this.endDate!)) {
        // this will show manage to show dates if dates are not same, note isSameMoments not working here
        strSelectedDate = stringRange;
      } else {
        // this will manage today, yesterday , tomorrow or dates if start and dates are same to show on screen
        strSelectedDate = this.startDate?.dateTimeVariable() ??
            (this.startDate == this.endDate
                ? this.startDate?.formatDDMMMYYYY(separator: '')
                : stringRange);
      }
    }
  }
}
