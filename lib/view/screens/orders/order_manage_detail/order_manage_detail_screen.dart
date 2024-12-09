import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_assign_driver_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_by_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_delete_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_download_invoice.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_driver_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_header_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_product_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/widgets/order_total_detail.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderManageDetailScreen extends StatelessWidget {
  const OrderManageDetailScreen({super.key});
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppbarWithBackIconAndTitle(
        title: 'Order Details'.tr,
      ),
      body: GetBuilder<OrderDetailController>(
        init: OrderDetailController(
            orderRepo: Get.find(), sharedPreferenceHelper: Get.find()),
        builder: (final OrderDetailController controller) {
          return controller.orderDetails != null
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            OrderDetailHeader(
                              orderDetails: controller.orderDetails,
                            ),
                            Gap(16),
                            OrderProductDetail(),
                            Gap(16),
                            OrderByDetail(),
                            Gap(16),
                            OrderTotalDetail(
                              orderDetails: controller.orderDetails,
                            ),
                            Gap((controller.orderDetails?.driver == null &&
                                    controller.orderDetails?.orderStatus !=
                                        OrderStatus.rejected)
                                ? 32
                                : 0),
                            (controller.orderDetails?.driver == null &&
                                    controller.orderDetails?.orderStatus ==
                                        OrderStatus.processing)
                                ? OrderAssignDriverWidget()
                                : SizedBox(),
                            Gap(controller.orderDetails?.driver != null
                                ? 16
                                : 0),
                            controller.orderDetails?.driver != null
                                ? OrderDriverDetail()
                                : SizedBox(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Gap(16),
                                OrderDownloadInvoice(
                                  onTapDownload: () {
                                    Get.find<GlobalController>()
                                        .downloadInvoice(
                                            controller
                                                    .orderDetails?.invoiceUrl ??
                                                '',
                                            controller.orderDetails?.orderId ??
                                                '');
                                  },
                                ),
                              ],
                            ),
                            Gap(16),
                          ],
                        ).paddingAll(16),
                      ),
                    ),
                    Visibility(
                      visible: controller.orderDetails?.orderStatus ==
                          OrderStatus.pending,
                      child: AcceptRejectWidget(controller),
                    ),
                    Visibility(
                      visible: controller.orderDetails?.orderStatus ==
                          OrderStatus.onTheWay,
                      child: CommonButton(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              onTap: () {
                                controller.onTapCompleteOrder();
                              },
                              title: 'Complete Order'.tr)
                          .paddingOnly(top: 16),
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

  Widget AcceptRejectWidget(final OrderDetailController controller) {
    return Column(
      children: <Widget>[
        Gap(16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              'Accept Order'.tr,
              style: mullerW500.copyWith(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onPressed: () {
              controller.acceptRejectOrder(isAccept: true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.color12658E,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
        Gap(12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              OrderDeleteBottomSheet.show();
            },
            child: Text(
              'Reject Order'.tr,
              style: mullerW500.copyWith(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorE52551,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              side: BorderSide(color: AppColors.colorE52551, width: 1),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
