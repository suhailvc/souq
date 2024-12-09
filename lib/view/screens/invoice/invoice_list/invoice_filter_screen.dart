import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/controller/invoice/invoice_filter_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/common_date_filter.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/bottomsheet/widgets/filter_status_item_wrap_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceFilterScreen extends StatelessWidget {
  const InvoiceFilterScreen({super.key});

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
        body: GetBuilder<InvoiceController>(
            builder: (final InvoiceController listController) {
          return GetBuilder<InvoiceFilterController>(
              init: InvoiceFilterController(),
              builder: (final InvoiceFilterController filterController) {
                return Column(
                  children: <Widget>[
                    Gap(8),
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Order Date'.tr,
                              style: mullerW400.copyWith(
                                  fontSize: 12, color: AppColors.color8ABCD5),
                            ),
                            Gap(4.0),
                            SizedBox(
                              height: 40,
                              child: CommonDateFilter(
                                filterFromDate: filterController.filterFromDate,
                                filterToDate: filterController.filterToDate,
                                onFromDateSelection: (final DateTime fromDate) {
                                  FocusScope.of(Get.context!).unfocus();
                                  filterController.onChangeFromDate(fromDate);
                                },
                                onToDateSelection: (final DateTime toDate) {
                                  FocusScope.of(Get.context!).unfocus();
                                  filterController.onChangeToDate(toDate);
                                },
                              ),
                            ),
                            Gap(20.0),
                            Text(
                              'Payment Status'.tr,
                              style: mullerW400.copyWith(
                                  fontSize: 12, color: AppColors.color8ABCD5),
                            ),
                            const Gap(8.0),
                            FilterStatusItemWrapWidget<PaymentModel>(
                              iconWithTitle: true,
                              list: filterController.paymentStatusList,
                              getPrintableText: (final PaymentModel item) {
                                return item.value ?? '';
                              },
                              selectedItem:
                                  filterController.selectedPaymentStatus,
                              onSelectItem:
                                  (final PaymentModel paymentStatusModel) {
                                filterController
                                    .setPaymentMode(paymentStatusModel);
                              },
                            ),
                            Gap(33),
                          ],
                        ).paddingSymmetric(horizontal: 16),
                      ),
                    ),
                    CommonButton(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.back();
                          listController.onTapApplyFilter(
                              filterController.getRequestModel());
                        },
                        title: 'Apply Filters'.tr),
                    Gap(16.0),
                    CommonButton(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.back();
                        listController.resetFilter();
                        listController.refreshInvoiceList();
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
                );
              });
        }),
      ),
    );
  }
}
