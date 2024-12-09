import 'package:atobuy_vendor_flutter/data/response_models/notifications/notification_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/notifications/widgets/notification_title_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NotificationCell extends StatelessWidget {
  const NotificationCell({super.key, required this.notification});

  final NotificationResults notification;
  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 45,
          height: 45,
          child: Stack(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.color2E236C.withOpacity(0.22),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    Assets.svg.icWalletUnselected,
                    colorFilter: ColorFilter.mode(
                        AppColors.color3D8FB9, BlendMode.srcIn),
                  ),
                ),
              ),
              notification.unread ?? false
                  ? Positioned(
                      top: 2,
                      left: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: AppColors.color3D8FB9,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Gap(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: notification.verb.isNotNullAndEmpty(),
                child: NotificationTitleTextSpan(
                  verb: notification.verb ?? '',
                ).paddingOnly(bottom: 6),
              ),
              Visibility(
                visible: notification.description.isNotNullAndEmpty(),
                child: Text(
                  notification.description ?? '',
                  style: mullerW400.copyWith(
                      color: AppColors.color757474, fontSize: 12),
                ).paddingOnly(bottom: 6),
              ),
              Text(
                notification.timestamp.format12HHMMA(),
                style: mullerW500.copyWith(
                    color: AppColors.color8ABCD5, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
