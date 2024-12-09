import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/invoice/invoice_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_list/widgets/invoice_grid_cell.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/total_result_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});
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
            title: 'Invoices Management'.tr,
          ),
          body: SafeArea(
            child: GetBuilder<InvoiceController>(
                init: InvoiceController(
                    invoiceRepo: Get.find(),
                    globalController: Get.find(),
                    sharedPref: Get.find()),
                builder: (final InvoiceController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SearchHeader(
                        onTapFilter: () {
                          FocusScope.of(context).unfocus();
                          controller.onTapFilter();
                        },
                        onTapSort: () {
                          FocusScope.of(context).unfocus();
                          controller.onTapSortBy();
                        },
                        textEditController: controller.txtSearchInvoice,
                        onSubmitSearch: (final String value) {
                          controller.submitSearchText(orderId: value);
                        },
                        onChangeSearch: (final String value) {
                          controller.changeSearchText(orderId: value);
                        },
                        onClearSearch: () {
                          controller.submitSearchText(orderId: '');
                        },
                      ),
                      TotalResultFoundWidget(
                        itemCounts: controller.itemCounts,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          color: AppColors.color2E236C,
                          onRefresh: () => controller.refreshInvoiceList(),
                          child: PagedGridView<int, Invoice>(
                            padding: EdgeInsets.all(16),
                            pagingController: controller.invoiceListController,
                            builderDelegate: PagedChildBuilderDelegate<Invoice>(
                              itemBuilder: (final BuildContext context,
                                      final Invoice invoice, final int index) =>
                                  InvoiceGridCell(
                                onTapInvoice: () {
                                  controller.onTapInvoice(invoice);
                                },
                                invoice: invoice,
                              ),
                              firstPageErrorIndicatorBuilder:
                                  (final BuildContext context) {
                                return NoItemFoundWidget(
                                  image: Assets.svg.icNoOrder,
                                  message: 'No invoices found!'.tr,
                                );
                              },
                              noItemsFoundIndicatorBuilder:
                                  (final BuildContext context) {
                                return NoItemFoundWidget(
                                  image: Assets.svg.icNoOrder,
                                  message: 'No invoices found!'.tr,
                                );
                              },
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 164 / 171,
                            ),
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
