import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDetailHeader extends StatelessWidget {
  const OrderDetailHeader(
      {super.key, this.isCustomerDetails = false, required this.orderDetails});

  final bool isCustomerDetails;

  final OrderDetailsModel? orderDetails;
  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.colorD0E4EE.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Gap(16.0),
          Text(
            'Order ID'.tr,
            style:
                mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
          ),
          Gap(10.0),
          Text(
            orderDetails?.orderId ?? '',
            style:
                mullerW500.copyWith(fontSize: 20, color: AppColors.color1D1D1D),
          ),
          Gap(16.0),
          Divider(
            height: 1,
            color: AppColors.colorB1D2E3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Gap(10.0),
                    Text(
                      'Date'.tr,
                      style: mullerW400.copyWith(
                          fontSize: 12, color: AppColors.color12658E),
                    ),
                    Gap(10.0),
                    Text(
                      orderDetails?.created != null
                          ? orderDetails!.created!.formatDDMMYY()
                          : '',
                      style: mullerW500.copyWith(color: AppColors.color1D1D1D),
                    ),
                    Gap(10.0),
                  ],
                ),
              ),
              VerticalDividerWidget(
                height: 65,
                color: AppColors.colorB1D2E3,
              ),
              Visibility(
                visible: !isCustomerDetails,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gap(10.0),
                      Text(
                        'Status'.tr,
                        style: mullerW400.copyWith(
                            fontSize: 12, color: AppColors.color12658E),
                      ),
                      Gap(10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Utility.getOrderStatusColor(
                              orderDetails?.orderStatus),
                        ),
                        child: Text(
                          orderDetails?.orderStatus?.title ?? '',
                          style: mullerW500.copyWith(
                              fontSize: 12, color: AppColors.white),
                        ),
                      ),
                      Gap(10.0),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !isCustomerDetails,
                child: VerticalDividerWidget(
                  height: 65,
                  color: AppColors.colorB1D2E3,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Gap(10.0),
                    Text(
                      'Payment'.tr,
                      style: mullerW400.copyWith(
                          fontSize: 12, color: AppColors.color12658E),
                    ),
                    Gap(10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(Assets.svg.icOnlinePayment),
                        Gap(3),
                        Text(
                          orderDetails?.paymentMode ?? '',
                          style:
                              mullerW500.copyWith(color: AppColors.color1D1D1D),
                        ),
                      ],
                    ),
                    Gap(10.0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
