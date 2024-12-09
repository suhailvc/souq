import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/home_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/dashed_separator.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderStatsWidget extends StatelessWidget {
  const OrderStatsWidget({super.key, required this.onTapDate});

  final VoidCallback onTapDate;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (final HomeController controller) {
      return GetBuilder<GlobalController>(
        builder: (final GlobalController globalController) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.color1679AB,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: onTapDate,
                          child: Text(
                            controller.filterModel.strSelectedDate ?? '',
                            style: mullerW500.copyWith(color: AppColors.white),
                          ),
                        ),
                        InkWell(
                          onTap: onTapDate,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.color12658E,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Filter'.tr,
                                  style: mullerW500.copyWith(
                                      color: AppColors.white, fontSize: 12),
                                ),
                                Gap(8.0),
                                SvgPicture.asset(Assets.svg.icArrowDown),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(24.0),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          Assets.svg.icAccountBalance,
                        ),
                        Gap(10.0),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'NO. of orders'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 14, color: AppColors.colorD0E4EE),
                              ),
                              Gap(5.0),
                              Text(
                                '${controller.orderStatistics?.totalOrders ?? 0}',
                                style: mullerW500.copyWith(
                                    fontSize: 18, color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                        VerticalDividerWidget(
                          height: 40.0,
                          color: AppColors.colorD0E4EE,
                        ).paddingSymmetric(horizontal: 16.0),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Total sales'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 14, color: AppColors.colorD0E4EE),
                              ),
                              Gap(5.0),
                              Text(
                                controller.orderStatistics
                                        ?.getTotalSalesPrice() ??
                                    controller.defaultPrice(),
                                style: mullerW500.copyWith(
                                    fontSize: 18, color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(18.0),
                    DashedSeparator(
                      color: AppColors.colorD0E4EE.withOpacity(0.20),
                      dashWidth: 5,
                    ),
                    Gap(18.0),
                    Column(
                      children: <Widget>[
                        _paymentsTypesWidget(
                          image: Assets.svg.icOnlinePayment,
                          title: 'Orders amount with online payment'.tr,
                          price: controller.orderStatistics
                                  ?.getTotalOnlinePayments() ??
                              controller.defaultPrice(),
                          globalController: globalController,
                        ),
                        Gap(12.0),
                        _paymentsTypesWidget(
                          image: Assets.svg.icCodPaymentGrey,
                          title: 'Orders amount with cash on delivery'.tr,
                          price: controller.orderStatistics
                                  ?.getTotalCODPayments() ??
                              controller.defaultPrice(),
                          globalController: globalController,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16);
        },
      );
    });
  }

  Widget _paymentsTypesWidget(
      {required final String image,
      required final String title,
      required final String price,
      required final GlobalController globalController}) {
    return Row(
      children: <Widget>[
        Container(
          height: 40.0,
          width: 40.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.color1F2023.withOpacity(0.20),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColors.colorCAE0E1.withOpacity(0.20)),
          ),
          child: SvgPicture.asset(
            image,
            colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
        Gap(10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                title,
                style: mullerW400.copyWith(
                    color: AppColors.colorD0E4EE, fontSize: 14),
              ),
              Text(
                price,
                style:
                    mullerW500.copyWith(fontSize: 18, color: AppColors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
