import 'package:atobuy_vendor_flutter/controller/checkout_controller.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/checkout_main_item_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutListWidget extends StatelessWidget {
  const CheckoutListWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (final CheckoutController controller) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.vendorModelList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (final BuildContext context, final int index) {
            return CheckoutMainItemRow(
              vendorModel: controller.vendorModelList[index],
            );
          },
        );
      },
    );
  }
}
