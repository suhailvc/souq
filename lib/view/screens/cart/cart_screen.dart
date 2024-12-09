import 'package:atobuy_vendor_flutter/controller/cart/cart_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/cart_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/price_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/shipping_address_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        appBar: AppbarWithBackIconAndTitle(
          title: 'Your Cart'.tr,
        ),
        body: GetBuilder<CartController>(
            init: CartController(
              cartRepo: Get.find(),
            ),
            builder: (final CartController controller) {
              return controller.cartListController.itemList.isNotNullOrEmpty()
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshCart,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Gap(20),
                                  ShippingAddressWidget()
                                      .paddingSymmetric(horizontal: 16),
                                  Gap(16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                  ).paddingSymmetric(horizontal: 16),
                                  Gap(16),
                                  CartWidget().paddingSymmetric(horizontal: 16),
                                  Gap(16),
                                  Container(
                                    color: AppColors.colorE8EBEC,
                                    height: 8,
                                  ),
                                  PriceWidget(
                                    cartModel: controller.cartModel,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.selectedAddress == null) {
                              showCustomSnackBar(
                                  message: 'Please select shipping address'.tr);
                              return;
                            }
                            Get.toNamed(RouteHelper.checkout,
                                arguments: <String, dynamic>{
                                  'cart': controller.cartModel,
                                  'address': controller.selectedAddress,
                                });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.color12658E,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color:
                                      AppColors.color3D8FB9.withOpacity(0.15),
                                  blurRadius: 12,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 12),
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Proceed To Checkout'.tr,
                                  style: mullerW500.copyWith(
                                      color: AppColors.white, fontSize: 16),
                                ),
                                Spacer(),
                                controller.cartModel.results.isNotNullOrEmpty()
                                    ? Text(
                                        controller.cartModel
                                            .getTotalPriceToPay(),
                                        style: mullerW700.copyWith(
                                            color: AppColors.white,
                                            fontSize: 16),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Gap(MediaQuery.of(context).padding.bottom > 0
                            ? MediaQuery.of(context).padding.bottom
                            : 16),
                      ],
                    )
                  : controller.isLoading
                      ? SizedBox()
                      : Center(
                          child: NoItemFoundWidget(
                            image: Assets.svg.icNoProduct,
                            message: 'Your cart is empty'.tr,
                          ),
                        );
            }),
      ),
    );
  }
}
