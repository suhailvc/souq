import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/purchase_history/purchase_history_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/order_list_cell.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/total_result_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});
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
            title: 'Order'.tr,
          ),
          body: SafeArea(
            child: GetBuilder<PurchaseHistoryListController>(
                builder: (final PurchaseHistoryListController controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SearchHeader(
                    textEditController: controller.searchOrderByName,
                    onSubmitSearch: (final String value) {
                      controller.onSubmitSearchOrderByName(value);
                    },
                    onChangeSearch: (final String value) {
                      controller.onChangeSearchOrderByName(value);
                    },
                    onClearSearch: () {
                      controller.onSubmitSearchOrderByName('');
                    },
                    onTapFilter: () {
                      FocusScope.of(context).unfocus();
                      Get.toNamed(RouteHelper.purchaseHistoryFilter);
                    },
                    onTapSort: () {
                      controller.onTapSort();
                    },
                  ),
                  TotalResultFoundWidget(itemCounts: controller.itemsCount),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.color2E236C,
                      onRefresh: () => controller.refreshOrderList(),
                      child: PagedListView<int, OrderDetailsModel>.separated(
                        pagingController: controller.orderListController,
                        builderDelegate:
                            PagedChildBuilderDelegate<OrderDetailsModel>(
                          itemBuilder: (final BuildContext context,
                                  final OrderDetailsModel order,
                                  final int index) =>
                              OrderListCell(
                            order: order,
                            isCustomerOrder: true,
                            onTapOrder: () {
                              Get.toNamed(
                                RouteHelper.purchaseHistoryDetails,
                                arguments: <String, String?>{
                                  'order_id': order.orderId
                                },
                              );
                            },
                            onTapMore: () {
                              Get.find<GlobalController>().downloadInvoice(
                                  order.invoiceUrl ?? '', order.orderId ?? '');
                            },
                          ),
                          firstPageErrorIndicatorBuilder:
                              (final BuildContext context) {
                            return NoItemFoundWidget(
                              image: Assets.svg.icNoOrder,
                              message:
                                  'No orders yet.\nAll your incoming, completed and cancelled orders\nwill be visible here'
                                      .tr,
                            );
                          },
                          noItemsFoundIndicatorBuilder:
                              (final BuildContext context) {
                            return NoItemFoundWidget(
                              image: Assets.svg.icNoOrder,
                              message:
                                  'No orders yet.\nAll your incoming, completed and cancelled orders\nwill be visible here'
                                      .tr,
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
