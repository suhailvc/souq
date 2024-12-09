import 'package:atobuy_vendor_flutter/controller/notification/notification_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/notifications/notification_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/notifications/widgets/notification_cell_header_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GetBuilder<NotificationController>(
        init: NotificationController(notificationRepo: Get.find()),
        builder: (final NotificationController controller) {
          return Scaffold(
            appBar: AppbarWithBackIconAndTitle(
              title: 'Notifications'.tr,
            ),
            body: SafeArea(
              child: RefreshIndicator(
                color: AppColors.color2E236C,
                onRefresh: () => controller.refreshNotificationList(),
                child: PagedListView<int, NotificationsModel>.separated(
                  pagingController: controller.notificationListController,
                  builderDelegate:
                      PagedChildBuilderDelegate<NotificationsModel>(
                    itemBuilder: (final BuildContext context,
                            final NotificationsModel item, final int index) =>
                        NotificationCellHeaderWidget(
                      timestamp: item.timestamp,
                      notifications:
                          item.notification ?? <NotificationResults>[],
                    ),
                    firstPageErrorIndicatorBuilder:
                        (final BuildContext context) {
                      return _noDataFoundWidget();
                    },
                    noItemsFoundIndicatorBuilder: (final BuildContext context) {
                      return _noDataFoundWidget();
                    },
                  ),
                  separatorBuilder:
                      (final BuildContext context, final int index) {
                    return Divider(
                      color: AppColors.colorB1D2E3,
                    ).paddingOnly(top: 8);
                  },
                ),
              ).paddingSymmetric(horizontal: 16),
            ),
          );
        },
      ),
    );
  }

  Widget _noDataFoundWidget() {
    return NoItemFoundWidget(
      image: Assets.svg.icNoOrder,
      message: 'You didn\'t received any notification'.tr,
    );
  }
}
