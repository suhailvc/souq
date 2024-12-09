import 'package:atobuy_vendor_flutter/data/response_models/notifications/notification_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/notifications/widgets/notification_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationCellHeaderWidget extends StatelessWidget {
  const NotificationCellHeaderWidget(
      {super.key, required this.notifications, this.timestamp});

  final List<NotificationResults> notifications;
  final DateTime? timestamp;
  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: timestamp != null,
          child: Text(
            timestamp?.dateTimeVariable() ?? timestamp.formatDDMMMYYYY(),
            style: mullerW500.copyWith(color: AppColors.color757474),
          ).paddingSymmetric(horizontal: 16, vertical: 20),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (final BuildContext context, final int index) {
            return NotificationCell(notification: notifications[index]);
          },
          separatorBuilder: (final BuildContext context, final int index) {
            return Divider(
              color: AppColors.colorB1D2E3,
            ).paddingSymmetric(vertical: 8);
          },
        ),
      ],
    );
  }
}
