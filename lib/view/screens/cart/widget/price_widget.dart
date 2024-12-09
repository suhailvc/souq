import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.cartModel});

  final CartModel? cartModel;

  @override
  Widget build(final BuildContext context) {
    return cartModel?.results != null
        ? Column(
            children: <Widget>[
              Gap(20),
              Row(
                children: <Widget>[
                  Text(
                    'Sub Total'.tr,
                    style: mullerW400.copyWith(
                        color: AppColors.color677A81, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    cartModel?.getTotalPriceWithCurrency() ?? '',
                    style: mullerW500.copyWith(
                        color: AppColors.color20163A, fontSize: 16),
                  )
                ],
              ).paddingSymmetric(horizontal: 16),
              Gap(11),
              Row(
                children: <Widget>[
                  Text(
                    'Discount'.tr,
                    style: mullerW400.copyWith(
                        color: AppColors.color677A81, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    cartModel?.getDiscountedPriceWithCurrency() ?? '',
                    style: mullerW500.copyWith(
                        color: AppColors.color20163A, fontSize: 16),
                  )
                ],
              ).paddingSymmetric(horizontal: 16),
              Gap(11),
              Row(
                children: <Widget>[
                  Text(
                    'Taxes'.tr,
                    style: mullerW400.copyWith(
                        color: AppColors.color677A81, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    cartModel?.getTaxAmountWithCurrency() ?? '',
                    style: mullerW500.copyWith(
                        color: AppColors.color20163A, fontSize: 16),
                  )
                ],
              ).paddingSymmetric(horizontal: 16),
              Gap(11),
              Row(
                children: <Widget>[
                  Text(
                    'Total Delivery Charges'.tr,
                    style: mullerW400.copyWith(
                        color: AppColors.color677A81, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    cartModel?.getDeliveryChargesWithCurrency() ?? '',
                    style: mullerW500.copyWith(
                        color: AppColors.color20163A, fontSize: 16),
                  )
                ],
              ).paddingSymmetric(horizontal: 16),
              Gap(12),
              Divider(
                color: AppColors.colorE8EBEC,
                height: 2,
              ).paddingSymmetric(horizontal: 16),
              Gap(12),
              Row(
                children: <Widget>[
                  Text(
                    'Grand Total'.tr,
                    style: mullerW700.copyWith(
                        color: AppColors.color171236, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    cartModel?.getOfferPriceWithCurrency() ?? '',
                    style: mullerW700.copyWith(
                        color: AppColors.color171236, fontSize: 16),
                  )
                ],
              ).paddingSymmetric(horizontal: 16),
              Gap(12),
            ],
          )
        : Container();
  }
}
