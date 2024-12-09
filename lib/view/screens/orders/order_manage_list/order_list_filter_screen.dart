import 'package:atobuy_vendor_flutter/controller/order/order_filter_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/order_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/common_date_filter.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/bottomsheet/widgets/filter_status_item_wrap_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/min_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderListFilterScreen extends StatelessWidget {
  const OrderListFilterScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppbarWithBackIconAndTitle(
          title: 'Filters'.tr,
        ),
        body: GetBuilder<OrderListController>(
            builder: (final OrderListController listController) {
          return GetBuilder<OrderFilterController>(
              init: OrderFilterController(listController: listController),
              builder: (final OrderFilterController filterController) {
                return Column(
                  children: <Widget>[
                    Gap(8),
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Order ID'.tr,
                                  style: mullerW400.copyWith(
                                      fontSize: 12,
                                      color: AppColors.color8ABCD5),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: CommonSearchTextField(
                                    labelText: 'Order ID'.tr,
                                    controller: filterController.txtOrderId,
                                    contentPadding:
                                        EdgeInsets.only(bottom: 8.0),
                                    prefixIcon: SizedBox(
                                      width: 12,
                                    ),
                                    labelStyle: mullerW400.copyWith(
                                        fontSize: 12,
                                        color: AppColors.color8ABCD5),
                                  ),
                                ),
                                Gap(20),
                                Text(
                                  'Order Date'.tr,
                                  style: mullerW400.copyWith(
                                      fontSize: 12,
                                      color: AppColors.color8ABCD5),
                                ),
                                Gap(4.0),
                                SizedBox(
                                  height: 40,
                                  child: CommonDateFilter(
                                    filterFromDate:
                                        filterController.filterFromDate,
                                    filterToDate: filterController.filterToDate,
                                    onFromDateSelection:
                                        (final DateTime fromDate) {
                                      FocusScope.of(Get.context!).unfocus();
                                      filterController
                                          .onChangeFromDate(fromDate);
                                    },
                                    onToDateSelection: (final DateTime toDate) {
                                      FocusScope.of(Get.context!).unfocus();
                                      filterController.onChangeToDate(toDate);
                                    },
                                  ),
                                ),
                                Gap(20.0),
                                Text(
                                  'Price Range'.tr,
                                  style: mullerW400.copyWith(
                                      fontSize: 12,
                                      color: AppColors.color8ABCD5),
                                ),
                                Gap(4.0),
                              ],
                            ).paddingSymmetric(horizontal: 16),
                            RangeSlider(
                                values: filterController.rangeValues,
                                min: listController.minPrice,
                                max: listController.maxPrice,
                                activeColor: AppColors.color2E236C,
                                inactiveColor: AppColors.colorE8EBEC,
                                onChanged: (final RangeValues value) {
                                  filterController.onChangeRange(value);
                                }),
                            Gap(8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                                            controller:
                                                filterController.txtMinPrice,
                                            priceRangeData:
                                                listController.priceRangeData,
                                            onChange: (final String value) {
                                              filterController
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
                                            controller:
                                                filterController.txtMaxPrice,
                                            priceRangeData:
                                                listController.priceRangeData,
                                            onChange: (final String value) {
                                              filterController
                                                  .onChangeMaxPriceRange(value);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Order Status'.tr,
                                      style: mullerW400.copyWith(
                                          fontSize: 12,
                                          color: AppColors.color8ABCD5),
                                    ),
                                    const Gap(8.0),
                                    FilterStatusItemWrapWidget<OrderStatus>(
                                      list: OrderStatus.values,
                                      getPrintableText:
                                          (final OrderStatus item) {
                                        return item.title.tr;
                                      },
                                      selectedItem:
                                          filterController.selectedOrderStatus,
                                      onSelectItem:
                                          (final OrderStatus orderStatusModel) {
                                        filterController
                                            .setOrderStatus(orderStatusModel);
                                      },
                                    ),
                                  ],
                                ),
                                Gap(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Payment Status'.tr,
                                      style: mullerW400.copyWith(
                                          fontSize: 12,
                                          color: AppColors.color8ABCD5),
                                    ),
                                    const Gap(8.0),
                                    FilterStatusItemWrapWidget<PaymentModel>(
                                      iconWithTitle: true,
                                      list: filterController.paymentStatusList,
                                      getPrintableText:
                                          (final PaymentModel item) {
                                        return item.value ?? '';
                                      },
                                      selectedItem: filterController
                                          .selectedPaymentStatus,
                                      onSelectItem: (final PaymentModel
                                          paymentStatusModel) {
                                        filterController
                                            .setPaymentMode(paymentStatusModel);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 16),
                            Gap(33),
                          ],
                        ),
                      ),
                    ),
                    CommonButton(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Get.back();
                              listController.rangeValues =
                                  filterController.rangeValues;
                              listController.onTapApplyFilter(
                                  filterController.getRequestModel());
                            },
                            title: 'Apply Filters'.tr)
                        .paddingSymmetric(horizontal: 16.0),
                    Gap(16.0),
                    CommonButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.back();
                        listController.resetFilter();
                        listController.refreshOrderList();
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
              });
        }),
      ),
    );
  }
}
