import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/purchase_history/purchase_history_detail_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_download_invoice.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_header_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_total_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purhcase_history/widgets/customer_order_details_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purhcase_history/widgets/order_billing_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PurchaseHistoryDetailScreen extends StatelessWidget {
  const PurchaseHistoryDetailScreen({super.key});
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppbarWithBackIconAndTitle(
        title: 'Order Details'.tr,
      ),
      body: GetBuilder<PurchaseHistoryDetailController>(
        builder: (final PurchaseHistoryDetailController controller) {
          return controller.orderDetails != null
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            OrderDetailHeader(
                              isCustomerDetails: true,
                              orderDetails: controller.orderDetails,
                            ),
                            Gap(16),
                            OrderBillingInfo(
                              billingAddress:
                                  controller.orderDetails?.billingAddress,
                              vendorName: controller.orderDetails?.vendorName,
                            ),
                            Divider(
                              height: 1,
                              color: AppColors.colorB1D2E3,
                            ).paddingSymmetric(vertical: 16),
                            CustomerOrderDetails(
                              subOrders: controller.orderDetails?.subOrders ??
                                  <OrderDetailsModel>[],
                            ),
                            Gap(16.0),
                            OrderTotalDetail(
                              orderDetails: controller.orderDetails,
                            ),
                          ],
                        ).paddingAll(16),
                      ),
                    ),
                    OrderDownloadInvoice(
                      onTapDownload: () {
                        Get.find<GlobalController>().downloadInvoice(
                            controller.orderDetails?.invoiceUrl ?? '',
                            controller.orderDetails?.orderId ?? '');
                      },
                    ).paddingSymmetric(horizontal: 16),
                    Gap(16.0),
                    CommonButton(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        controller.contactUs();
                        controller.openWhatsApp(controller.orderId);
                      },
                      title: 'Contact us'.tr,
                      titleColor: AppColors.color12658E,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.color8ABCD5),
                      ),
                    ),
                    Gap(MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom
                        : 16)
                  ],
                )
              : controller.isDetailsLoading
                  ? SizedBox()
                  : NoItemFoundWidget(
                      image: Assets.svg.icNoOrder,
                      message: 'No order details found!'.tr,
                    );
        },
      ),
    );
  }
}
