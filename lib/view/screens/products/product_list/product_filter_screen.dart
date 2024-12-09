import 'package:atobuy_vendor_flutter/controller/product/product_filter_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/filter_item_wrap_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/min_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductFilterScreen extends StatelessWidget {
  const ProductFilterScreen({final Key? key}) : super(key: key);

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
            title: 'Filter'.tr,
          ),
          body: SafeArea(
            child: GetBuilder<ProductListController>(
                builder: (final ProductListController productListController) {
              return GetBuilder<ProductFilterController>(
                init: ProductFilterController(
                    globalController: Get.find(),
                    productListController: productListController),
                builder: (final ProductFilterController controller) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Gap(15.0),
                              Text(
                                'Category'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.color8ABCD5),
                              ).paddingSymmetric(horizontal: 16.0),
                              const Gap(8.0),
                              FilterItemWrapWidget<Category>(
                                list: productListController.categoryList,
                                getPrintableText: (final Category item) {
                                  return item.getName();
                                },
                                selectedItem: controller.selectedCategory,
                                onSelectItem: (final Category category) {
                                  controller.onSelectCategory(
                                      selectedCategory: category,
                                      controller: productListController);
                                },
                              ).paddingSymmetric(horizontal: 16.0),
                              const Gap(16.0),
                              Visibility(
                                visible: productListController
                                    .subCategoryList.isNotEmpty,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Sub Category'.tr,
                                      style: mullerW400.copyWith(
                                          fontSize: 12,
                                          color: AppColors.color8ABCD5),
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(horizontal: 16.0),
                              const Gap(8.0),
                              FilterItemWrapWidget<Category>(
                                list: productListController.subCategoryList,
                                getPrintableText: (final Category item) {
                                  return item.getName();
                                },
                                selectedItem: controller.selectedSubCategory,
                                onSelectItem: (final Category category) {
                                  controller.onSelectSubCategory(
                                      subCategory: category);
                                },
                              ).paddingSymmetric(horizontal: 16.0),
                              Gap(16.0),
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
                                            controller
                                                .onChangeMinPriceRange(value);
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
                              const Gap(16.0),
                              Visibility(
                                visible:
                                    productListController.selectedTabIndex == 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Approval Status'.tr,
                                      style: mullerW400.copyWith(
                                          fontSize: 12,
                                          color: AppColors.color8ABCD5),
                                    ),
                                    const Gap(16.0),
                                    FilterItemWrapWidget<ProductApprovalStatus>(
                                      list: controller.statusList,
                                      getPrintableText:
                                          (final ProductApprovalStatus item) {
                                        return item.title.tr;
                                      },
                                      selectedItem: controller
                                          .selectedProductApprovalStatus,
                                      onSelectItem: (final ProductApprovalStatus
                                          productStatusModel) {
                                        controller.onApprovalStatusSelected(
                                            productStatusModel:
                                                productStatusModel);
                                      },
                                      isStatus: true,
                                    ),
                                  ],
                                ),
                              ).paddingSymmetric(horizontal: 16.0),
                              const Gap(16.0),
                              Text(
                                'Product Status'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.color8ABCD5),
                              ).paddingSymmetric(horizontal: 16.0),
                              const Gap(16.0),
                              FilterItemWrapWidget<ProductStatus>(
                                list: controller.productStatusList,
                                getPrintableText: (final ProductStatus item) {
                                  return item.title.tr;
                                },
                                selectedItem: controller.selectedProductStatus,
                                onSelectItem:
                                    (final ProductStatus productStatusModel) {
                                  controller.onProductStatusSelected(
                                      productStatusModel: productStatusModel);
                                },
                                isStatus: true,
                              ).paddingSymmetric(horizontal: 16.0),
                              const Gap(30),
                            ],
                          ),
                        ),
                      ),
                      CommonButton(
                              onTap: () {
                                controller.onTapApplyFilter();
                              },
                              title: 'Apply Filters'.tr)
                          .paddingSymmetric(horizontal: 16.0),
                      Gap(16.0),
                      CommonButton(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.back();
                          productListController.resetFilter();
                          productListController.update();
                          productListController.refreshProductList();
                        },
                        title: 'Reset Filters'.tr,
                        titleColor: AppColors.color12658E,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.color8ABCD5),
                        ),
                      ).paddingSymmetric(horizontal: 16.0),
                      Gap(MediaQuery.of(context).padding.bottom > 0
                          ? MediaQuery.of(context).padding.bottom
                          : 34),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
