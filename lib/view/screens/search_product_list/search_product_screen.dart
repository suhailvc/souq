import 'package:atobuy_vendor_flutter/controller/product/search/search_product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/total_result_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/product_sort_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/store_product_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchProductScreen extends StatelessWidget {
  final String tag = Utility.getRandomString(10);
  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<SearchProductListController>(
            tag: tag,
            init: SearchProductListController(
                sharedPref: Get.find(),
                productRepo: Get.find(),
                globalController: Get.find()),
            builder: (final SearchProductListController controller) {
              return Scaffold(
                appBar: AppbarWithBackIconAndTitle(
                  title: 'Products'.tr,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SearchHeader(
                      onTapFilter: () {
                        FocusScope.of(context).unfocus();
                        Get.toNamed(RouteHelper.searchProductFilter,
                            arguments: <String, String>{'tag': tag});
                      },
                      onTapSort: () {
                        FocusScope.of(context).unfocus();
                        Get.bottomSheet(
                          ProductSortBottomSheet(
                            sortSelectedValue:
                                controller.requestModel.sortSelectedValue,
                            onSubmit: (final SortOptions option) {
                              controller.onSelectSortType(option);
                              controller.applyFilterRefresh();
                            },
                            onReset: (final SortOptions option) {
                              controller
                                  .onSelectSortType(SortOptions.newestFirst);
                              controller.applyFilterRefresh();
                            },
                          ),
                          isDismissible: true,
                          enableDrag: true,
                          isScrollControlled: true,
                        );
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
                    TotalResultFoundWidget(itemCounts: controller.itemsCount),
                    Expanded(
                      child: RefreshIndicator(
                        color: AppColors.color2E236C,
                        onRefresh: () => controller.handleRefresh(
                            controller.allProductPagingController),
                        child: PagedGridView<int, ProductDetailsModel>(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.all(16),
                          pagingController:
                              controller.allProductPagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<ProductDetailsModel>(
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
                                    'product_id': productModel.id
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
                            childAspectRatio: 109 / 185,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
