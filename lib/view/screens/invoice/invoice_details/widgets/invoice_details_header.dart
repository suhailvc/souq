import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceDetailsHeader extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<InvoiceController>(
        builder: (final InvoiceController controller) {
      return Column(
        children: <Widget>[
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: <Widget>[
                Gap(16.0),
                Text(
                  'Order ID'.tr,
                  style: mullerW400.copyWith(
                    fontSize: 12,
                    color: AppColors.color12658E,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(12.0),
                Text(
                  controller.selectedInvoice?.orderId ?? '',
                  style: mullerW500.copyWith(
                    fontSize: 20,
                    color: AppColors.color2E236C,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(16.0),
                Divider(
                  height: 1,
                  color: AppColors.colorB1D2E3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Gap(10.0),
                          Text(
                            'Date'.tr,
                            style: mullerW400.copyWith(
                                fontSize: 12, color: AppColors.color12658E),
                          ),
                          Gap(10.0),
                          Text(
                            '${controller.selectedInvoice?.created.formatDDMMYYYY()}',
                            style: mullerW500.copyWith(
                                color: AppColors.color2E236C),
                          ),
                          Gap(10.0),
                        ],
                      ),
                    ),
                    VerticalDividerWidget(
                      height: 65,
                      color: AppColors.colorB1D2E3,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Gap(10.0),
                          Text(
                            'Payment'.tr,
                            style: mullerW400.copyWith(
                                fontSize: 12, color: AppColors.color12658E),
                          ),
                          Gap(10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(Assets.svg.icOnlinePayment),
                              Gap(8.0),
                              Text(
                                controller.selectedInvoice?.paymentMode ?? '',
                                style: mullerW500.copyWith(
                                    color: AppColors.color2E236C),
                              ),
                            ],
                          ),
                          Gap(10.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
