import 'package:atobuy_vendor_flutter/controller/product/stores/store_product_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/stores/store_product_filter_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/min_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopProductFilterBottomSheet extends StatelessWidget {
  const ShopProductFilterBottomSheet({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<StoreProductController>(
            builder: (final StoreProductController productListController) {
          return GetBuilder<StoreProductFilterController>(
            init: StoreProductFilterController(
                productListController: productListController),
            builder: (final StoreProductFilterController controller) {
              return Container(
                height: Get.height * 0.55,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    AppbarWithBackIconAndTitle(
                      title: 'Filter'.tr,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Price Range'.tr,
                              style: mullerW400.copyWith(
                                  fontSize: 12, color: AppColors.color8ABCD5),
                            ).paddingSymmetric(horizontal: 16.0),
                            Gap(4.0),
                            RangeSlider(
                                values: controller.rangeValues,
                                min: productListController.minPrice,
                                max: productListController.maxPrice,
                                activeColor: AppColors.color2E236C,
                                inactiveColor: AppColors.colorE8EBEC,
                                onChanged: (final RangeValues value) {
                                  controller.setPriceValue(value);
                                }),
                            const Gap(16.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Min.'.tr,
                                        style: mullerW400.copyWith(
                                          fontSize: 12.0,
                                          color: AppColors.color8ABCD5,
                                        ),
                                      ),
                                      Gap(12.0),
                                      FilterPriceWidget(
                                        controller: controller.txtMinEc,
                                        priceRangeData: productListController
                                            .priceRangeData,
                                        onChange: (final String value) {
                                          controller.onChangeMinPriceRange(
                                              value, productListController);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(15.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Max.'.tr,
                                        style: mullerW400.copyWith(
                                          fontSize: 12.0,
                                          color: AppColors.color8ABCD5,
                                        ),
                                      ),
                                      Gap(12.0),
                                      FilterPriceWidget(
                                        controller: controller.txtMaxEc,
                                        priceRangeData: productListController
                                            .priceRangeData,
                                        onChange: (final String value) {
                                          controller
                                              .onChangeMaxPriceRange(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 16.0),
                            const Gap(30),
                          ],
                        ),
                      ),
                    ),
                    CommonButton(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        onTap: () {
                          controller.onTapApplyFilter();
                        },
                        title: 'Apply Filters'.tr),
                    Gap(16.0),
                    CommonButton(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        controller.onTapResetFilter();
                      },
                      title: 'Reset Filters'.tr,
                      titleColor: AppColors.color12658E,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.color8ABCD5),
                      ),
                    ),
                    Gap(MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom
                        : 16),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
