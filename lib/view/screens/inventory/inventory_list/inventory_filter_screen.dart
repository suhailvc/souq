import 'package:atobuy_vendor_flutter/controller/inventory/inventory_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/filter_item_wrap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventoryFilterScreen extends StatelessWidget {
  const InventoryFilterScreen({
    super.key,
  });

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
            title: 'Filters'.tr,
          ),
          body: GetBuilder<InventoryListController>(initState:
              (final GetBuilderState<InventoryListController> state) {
            Get.find<InventoryListController>().initialiseFilters();
          }, builder: (final InventoryListController controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Gap(30.0),
                        Text(
                          'Category'.tr,
                          style: mullerW400.copyWith(
                              fontSize: 12, color: AppColors.color8ABCD5),
                        ),
                        const Gap(8.0),
                        FilterItemWrapWidget<Category>(
                          list: controller.categoryList,
                          getPrintableText: (final Category item) {
                            return item.getName();
                          },
                          selectedItem: controller.selectedTempCategory,
                          onSelectItem: (final Category category) {
                            controller.onSelectCategory(
                                selectedCategory: category);
                          },
                        ),
                        const Gap(16.0),
                        Visibility(
                          visible: controller.subCategoryList.isNotEmpty,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Sub Category'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.color8ABCD5),
                              ),
                            ],
                          ),
                        ),
                        const Gap(8.0),
                        FilterItemWrapWidget<Category>(
                          list: controller.subCategoryList,
                          getPrintableText: (final Category item) {
                            return item.getName();
                          },
                          selectedItem: controller.selectedTempSubCategory,
                          onSelectItem: (final Category category) {
                            controller.onSelectSubCategory(
                                subCategory: category);
                          },
                        ),
                        const Gap(24.0),
                      ],
                    ),
                  ),
                ),
                CommonButton(
                    onTap: () {
                      Get.back();
                      controller.applyFilterRefresh();
                    },
                    title: 'Apply Filters'.tr),
                Gap(16.0),
                CommonButton(
                  onTap: () {
                    Get.back();
                    controller.resetFilter();
                    controller.applyFilterRefresh();
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
                    : 34),
              ],
            ).paddingSymmetric(horizontal: 16.0);
          }),
        ),
      ),
    );
  }
}
