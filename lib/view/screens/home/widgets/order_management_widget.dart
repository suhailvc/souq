import 'package:atobuy_vendor_flutter/controller/home_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderManagementWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (final HomeController controller) {
      return Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.colorB1D2E3,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.colorD0E4EE,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.colorB1D2E3,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Orders Management'.tr,
                      style: mullerW500.copyWith(
                          fontSize: 16, color: AppColors.color1D1D1D),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.orderManageList);
                    },
                    icon: SvgPicture.asset(
                      alignment: Alignment.centerRight,
                      Assets.svg.icRightArrowRound,
                      matchTextDirection: true,
                      colorFilter: ColorFilter.mode(
                          AppColors.color1D1D1D, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _getOrderManagementOption(
                    statusColor: AppColors.color3D8FB9,
                    count:
                        controller.orderStatistics?.processingOrdersCount ?? 0,
                    title: 'Processing'.tr),
                VerticalDividerWidget(
                  height: 57.0,
                  color: AppColors.colorB1D2E3,
                ),
                _getOrderManagementOption(
                    statusColor: AppColors.colorE59825,
                    count: controller.orderStatistics?.pendingOrdersCount ?? 0,
                    title: 'Pending'.tr),
                VerticalDividerWidget(
                  height: 57.0,
                  color: AppColors.colorB1D2E3,
                ),
                _getOrderManagementOption(
                    statusColor: AppColors.color12658E,
                    count:
                        controller.orderStatistics?.deliveredOrdersCount ?? 0,
                    title: 'Delivered'.tr),
              ],
            ).paddingSymmetric(vertical: 16.0),
          ],
        ),
      );
    });
  }

  Widget _orderStatusColorWidget(final Color color) {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.0)),
    );
  }

  Widget _getOrderManagementOption(
      {required final Color statusColor,
      required final int? count,
      required final String title}) {
    return Column(
      children: <Widget>[
        _orderStatusColorWidget(statusColor),
        Gap(12.0),
        Text(
          title,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color757474),
        ),
        Gap(12.0),
        Text(
          count.toString(),
          style:
              mullerW500.copyWith(fontSize: 20, color: AppColors.color1D1D1D),
        ),
      ],
    );
  }
}
