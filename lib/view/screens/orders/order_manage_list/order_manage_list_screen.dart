import 'package:atobuy_vendor_flutter/controller/order/order_list_controller.dart';
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

class OrderManageListScreen extends StatelessWidget {
  const OrderManageListScreen({super.key});
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
            title: 'Order Management'.tr,
          ),
          body: SafeArea(
            child: GetBuilder<OrderListController>(
                init: OrderListController(
                  globalController: Get.find(),
                  orderRepo: Get.find(),
                  sharedPreferenceHelper: Get.find(),
                ),
                builder: (final OrderListController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SearchHeader(
                        onTapFilter: () {
                          FocusScope.of(context).unfocus();
                          Get.toNamed(RouteHelper.orderFilter);
                        },
                        onTapSort: () {
                          FocusScope.of(context).unfocus();
                          controller.onTapSortBy();
                        },
                        textEditController: controller.searchOrderByName,
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
                          onRefresh: () => controller.refreshOrderList(),
                          child:
                              PagedListView<int, OrderDetailsModel>.separated(
                            pagingController: controller.orderListController,
                            builderDelegate:
                                PagedChildBuilderDelegate<OrderDetailsModel>(
                              itemBuilder: (final BuildContext context,
                                      final OrderDetailsModel order,
                                      final int index) =>
                                  OrderListCell(
                                order: order,
                                onTapOrder: () {
                                  Get.toNamed(RouteHelper.orderManageDetail,
                                      arguments: <String, String?>{
                                        'order_id': order.orderId
                                      });
                                },
                                onTapMore: () {
                                  controller.onTapMore(order);
                                },
                              ),
                              firstPageErrorIndicatorBuilder:
                                  (final BuildContext context) {
                                return _noDataFoundWidget();
                              },
                              noItemsFoundIndicatorBuilder:
                                  (final BuildContext context) {
                                return _noDataFoundWidget();
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

  Widget _noDataFoundWidget() {
    return NoItemFoundWidget(
      image: Assets.svg.icNoOrder,
      message:
          'No orders yet.\nAll your incoming, completed and cancelled orders\nwill be visible here'
              .tr,
    );
  }
}
