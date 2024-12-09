import 'package:atobuy_vendor_flutter/controller/checkout_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/price_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/checkout_list_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/payment_card_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/payment_method_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/selected_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppbarWithBackIconAndTitle(
            title: 'Checkout'.tr,
          ),
          body: GetBuilder<CheckoutController>(
              init: CheckoutController(
                cartRepo: Get.find(),
                walletRepo: Get.find(),
              ),
              builder: (final CheckoutController controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Total Items'.tr,
                                  style: mullerW700.copyWith(
                                      color: AppColors.color20163A),
                                ),
                                Spacer(),
                                Container(
                                  width: 35,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: AppColors.color2E236C,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${controller.totalItems}',
                                      style: mullerW500.copyWith(
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 16.0),
                            Gap(16),
                            CheckoutListWidget(),
                            Gap(10),
                            Text(
                              'Delivery To'.tr,
                              style: mullerW500.copyWith(
                                  fontSize: 12, color: AppColors.color1D1D1D),
                            ).paddingSymmetric(horizontal: 16.0),
                            Gap(8),
                            SelectedAddressWidget(
                              selectedAddress: controller.selectedAddress,
                            ),
                            Gap(24),
                            Container(
                              color: AppColors.colorE8EBEC,
                              height: 4,
                            ),
                            Gap(24),
                            PaymentMethodWidget(),
                            Gap(10),
                            Visibility(
                              visible: (controller.selectedPaymentMethod?.key ==
                                  'online'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  PaymentCardWidget(),
                                  Gap(24),
                                ],
                              ),
                            ),
                            Container(
                              color: AppColors.colorE8EBEC,
                              height: 4,
                            ),
                            PriceWidget(
                              cartModel: controller.cartModel,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.selectedPaymentMethod == null) {
                          showCustomSnackBar(
                              message:
                                  'please select payment method to continue'
                                      .tr);
                          return;
                        }
                        controller.placeOrder();
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.color12658E,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppColors.color3D8FB9.withOpacity(0.15),
                              blurRadius: 12,
                              spreadRadius: 0,
                              offset: const Offset(0, 12),
                            )
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Continue Payment'.tr,
                              style: mullerW500.copyWith(
                                  color: AppColors.white, fontSize: 16),
                            ),
                            Spacer(),
                            Text(
                              controller.cartModel?.getTotalPriceToPay() ?? '',
                              style: mullerW700.copyWith(
                                  color: AppColors.white, fontSize: 16),
                            )
                          ],
                        ).paddingSymmetric(horizontal: 12),
                      ),
                    ),
                    Gap(MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom
                        : 16)
                  ],
                );
              }),
        ),
      ),
    );
  }
}
