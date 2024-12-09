import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/driver_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_assign_driver_row.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AssignDriverScreen extends StatelessWidget {
  const AssignDriverScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
      initState: (final GetBuilderState<OrderDetailController> state) {
        Get.find<OrderDetailController>().resetDriverSelection();
      },
      builder: (final OrderDetailController controller) {
        return Scaffold(
          appBar: AppbarWithBackIconAndTitle(
            title: 'Assign Driver'.tr,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Gap(8),
              SearchHeader(
                textEditController: controller.txtSearchDriver,
                labelText: 'Enter Driver Name'.tr,
                onSubmitSearch: (final String value) {
                  controller.onSubmitSearchDriver(value);
                },
                onChangeSearch: (final String value) {
                  controller.onChangeSearchDriver(value);
                },
                onClearSearch: () {
                  controller.onSubmitSearchDriver('');
                },
                showFilterOption: false,
                showSortOption: false,
              ),
              Gap(16),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.color2E236C,
                  onRefresh: () => controller.refreshDriverList(),
                  child: PagedListView<int, Driver>.separated(
                    padding: EdgeInsets.only(bottom: 100),
                    pagingController: controller.driverListController,
                    builderDelegate: PagedChildBuilderDelegate<Driver>(
                      itemBuilder: (final BuildContext context,
                              final Driver driver, final int index) =>
                          OrderAssignDriverRow(
                        driver: driver,
                        onSelect: () {
                          controller.onSelectDriver(index);
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
                      return SizedBox(
                        height: 12,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          extendBody: true,
          bottomNavigationBar:
              (controller.driverListController.itemList ?? <Driver>[])
                      .isNotEmpty
                  ? Container(
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              AppColors.white.withOpacity(0),
                              AppColors.white
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: <double>[0.6, 0.8]),
                      ),
                      child: CommonButton(
                          margin: EdgeInsets.symmetric(horizontal: 79),
                          onTap: () {
                            Get.back();
                            controller.assignDriver();
                          },
                          title: 'Select and Continue'.tr),
                    )
                  : SizedBox(),
        );
      },
    );
  }

  Widget _noDataFoundWidget() {
    return NoItemFoundWidget(
      image: Assets.svg.icNoOrder,
      message: 'No drivers found!'.tr,
    );
  }
}
