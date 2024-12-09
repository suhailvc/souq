import 'package:atobuy_vendor_flutter/controller/inventory/inventory_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_list/widgets/inventory_list_cell.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_list/widgets/inventory_sort_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/total_result_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InventoryListScreen extends StatelessWidget {
  const InventoryListScreen({super.key});
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
            title: 'Inventory Management'.tr,
          ),
          body: SafeArea(
            child: GetBuilder<InventoryListController>(
                init: InventoryListController(
                    globalController: Get.find(), inventoryRepo: Get.find()),
                builder: (final InventoryListController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SearchHeader(
                        onTapFilter: () {
                          Get.toNamed(RouteHelper.inventoryFilterScreen);
                        },
                        onTapSort: () {
                          Get.bottomSheet(
                            InventorySortBottomSheet(
                              sortSelectedValue: controller.selectedSort,
                              onSubmit: (final SortOptions option) {
                                controller.onSelectSortType(option);
                              },
                              onReset: (final SortOptions option) {
                                controller.onSelectSortType(option);
                              },
                            ),
                            isDismissible: true,
                            enableDrag: true,
                            isScrollControlled: true,
                          );
                        },
                        textEditController: controller.txtSearchInventory,
                        onSubmitSearch: (final String value) {
                          controller.onSubmitSearchText(value);
                        },
                        onChangeSearch: (final String value) {
                          controller.onChangeSearchText(value);
                        },
                        onClearSearch: () {
                          controller.onSubmitSearchText('');
                        },
                      ),
                      TotalResultFoundWidget(
                        itemCounts: controller.itemCounts,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          color: AppColors.color2E236C,
                          onRefresh: () => controller.refreshInventoryList(),
                          child: PagedListView<int, StoreModel>.separated(
                            padding: EdgeInsets.only(bottom: 100),
                            pagingController:
                                controller.inventoryListController,
                            builderDelegate:
                                PagedChildBuilderDelegate<StoreModel>(
                              itemBuilder: (final BuildContext context,
                                      final StoreModel inventory,
                                      final int index) =>
                                  InventoryListCell(
                                onSelectInventory: () {
                                  Get.toNamed(
                                    RouteHelper.inventoryDetails,
                                    arguments: <String, String>{
                                      'uuid': inventory.uuid ?? ''
                                    },
                                  );
                                },
                                inventory: inventory,
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
                            separatorBuilder:
                                (final BuildContext context, final int index) {
                              return Divider(
                                color: AppColors.colorB9C1C5,
                                thickness: 1,
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
