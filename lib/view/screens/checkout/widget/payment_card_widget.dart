import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/payment_card_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Select Card For Payment'.tr,
          style:
              mullerW500.copyWith(fontSize: 12, color: AppColors.color0B3D56),
        ),
        Gap(16.0),
        ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (final BuildContext context, final int index) {
              return PaymentCardRow();
            }),
      ],
    ).paddingSymmetric(horizontal: 16.0);
  }
}
