import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_amount_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderTotalDetail extends StatelessWidget {
  const OrderTotalDetail({super.key, this.orderDetails});

  final OrderDetailsModel? orderDetails;
  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Order Total'.tr,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
        ),
        Gap(8.0),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.colorD0E4EE.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              OrderAmountWidget(
                title: 'Subtotal'.tr,
                amount: orderDetails?.getSubTotalWithCurrency() ?? '',
                fontSize: 13,
              ),
              Gap(8.0),
              OrderAmountWidget(
                title: 'Extra Amount'.tr,
                amount: orderDetails?.getExtraAmountWithCurrency() ?? '',
                fontSize: 13,
              ),
              Gap(8.0),
              OrderAmountWidget(
                title: 'Tax'.tr,
                amount: orderDetails?.getOrderTaxWithCurrency() ?? '',
                fontSize: 13,
              ),
              Gap(8.0),
              OrderAmountWidget(
                title: 'Discount'.tr,
                amount: orderDetails?.getOrderDiscountWithCurrency() ?? '',
                fontSize: 13,
              ),
              Gap(8.0),
              OrderAmountWidget(
                title: 'Promo Discount'.tr,
                amount: orderDetails?.getOrderPromoDiscountWithCurrency() ?? '',
                fontSize: 13,
              ),
              Gap(8.0),
              OrderAmountWidget(
                title: 'Delivery Charge'.tr,
                amount: orderDetails?.getOrderDeliverChargeWithCurrency() ?? '',
                fontSize: 13,
              ),
              Gap(12.0),
              Divider(
                height: 1,
                color: AppColors.colorB1D2E3,
              ),
              Gap(12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total'.tr,
                    style: mullerW400.copyWith(
                        fontSize: 15, color: AppColors.color12658E),
                  ),
                  Text(
                    orderDetails?.getOrderTotalWithCurrency() ?? '',
                    style: mullerW700.copyWith(
                        fontSize: 15, color: AppColors.color171236),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
