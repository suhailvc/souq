import 'package:atobuy_vendor_flutter/controller/checkout_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/payment_method_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (final CheckoutController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select Payment Method'.tr,
              style: mullerW500.copyWith(
                  fontSize: 12, color: AppColors.color0B3D56),
            ),
            Gap(8.0),
            ListView.separated(
              itemCount: controller.paymentModeList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (final BuildContext context, final int index) {
                return PaymentMethodRow(
                  paymentMethod: controller.paymentModeList[index],
                  selectedPaymentMethod: controller.selectedPaymentMethod,
                  onPaymentMethodTap: (final PaymentModel paymentMethod) {
                    controller.onPaymentMethod(paymentMethod);
                  },
                  walletBalance: controller.walletBalance,
                );
              },
              separatorBuilder: (final BuildContext context, final int index) {
                return SizedBox(
                  height: 6,
                );
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 16.0);
      },
    );
  }
}
