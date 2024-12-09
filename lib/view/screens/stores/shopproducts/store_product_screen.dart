import 'package:atobuy_vendor_flutter/controller/product/stores/store_product_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/shopproducts/widgets/brand_selection_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/shopproducts/widgets/sub_category_tab_bar_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/store_product_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoreProductScreen extends StatelessWidget {
  const StoreProductScreen({final Key? key}) : super(key: key);
  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<StoreProductController>(
          builder: (final StoreProductController controller) {
            return Scaffold(
              appBar: AppbarWithBackIconTitleAndSuffixWidget(
                title: controller.selectedCategory?.getName() ?? 'Products'.tr,
                suffixWidget: Padding(
                  padding: EdgeInsetsDirectional.only(end: 16),
                  child: SouqCart.icon(),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SearchHeader(
                    onTapFilter: () {
                      FocusScope.of(context).unfocus();
                      controller.onTapFilter();
                    },
                    onTapSort: () {
                      FocusScope.of(context).unfocus();
                      controller.onTapSort();
                    },
                    textEditController: controller.txtSearchEc,
                    onSubmitSearch: (final String value) {
                      controller.setSearchText(value);
                    },
                    onChangeSearch: (final String value) {
                      controller.changeSearchText(value);
                    },
                    onClearSearch: () {
                      controller.setSearchText('');
                    },
                  ),
                  controller.tabController != null
                      ? SubCategoryTabBarWidget(
                          onTap: (final int index) {},
                          tabController: controller.tabController!,
                          arrTabs: controller.tabs,
                          isScrollable: true,
                          selectedColor: AppColors.color2E236C,
                          unSelectedColor: AppColors.color8ABCD5,
                          indicatorColor: AppColors.color2E236C,
                          selectedTabIndex: controller.selectedTabIndex,
                        )
                      : SizedBox(),
                  Gap(16),
                  Visibility(
                    visible: controller.arrBrands.isNotNullOrEmpty(),
                    child: BrandListWidget(),
                  ),
                  Expanded(
                    child: controller.tabController != null ||
                            controller.offer != null
                        ? RefreshIndicator(
                            color: AppColors.color2E236C,
                            onRefresh: () =>
                                controller.refreshStoreProductList(),
                            child: PagedGridView<int, ProductDetailsModel>(
                              padding: EdgeInsets.all(16),
                              pagingController:
                                  controller.shopProductPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                  ProductDetailsModel>(
                                itemBuilder: (final BuildContext context,
                                        final ProductDetailsModel item,
                                        final int index) =>
                                    StoreProductRow(
                                  productModel: item,
                                  onProductClick:
                                      (final ProductDetailsModel productModel) {
                                    Get.toNamed(
                                      RouteHelper.purchaseProductDetails,
                                      arguments: <String, dynamic>{
                                        'uuid': productModel.uuid,
                                        'product_id': productModel.id,
                                      },
                                    );
                                  },
                                ),
                                firstPageErrorIndicatorBuilder:
                                    (final BuildContext context) {
                                  return NoItemFoundWidget(
                                    image: Assets.svg.icNoProduct,
                                    message: 'No products found!'.tr,
                                  );
                                },
                                noItemsFoundIndicatorBuilder:
                                    (final BuildContext context) {
                                  return NoItemFoundWidget(
                                    image: Assets.svg.icNoProduct,
                                    message: 'No products found!'.tr,
                                  );
                                },
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                                childAspectRatio: 109 / 190,
                              ),
                            ),
                          )
                        : SizedBox(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
