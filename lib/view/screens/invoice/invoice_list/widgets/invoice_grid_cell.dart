import 'package:atobuy_vendor_flutter/data/response_models/invoice/invoice_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceGridCell extends StatelessWidget {
  const InvoiceGridCell(
      {super.key, required this.onTapInvoice, required this.invoice});

  final VoidCallback onTapInvoice;
  final Invoice invoice;
  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onTapInvoice,
      child: Container(
        padding:
            EdgeInsets.only(left: 8.0, top: 12.0, bottom: 16.0, right: 8.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.colorB1D2E3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 64,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.colorD0E4EE,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.svg.icInvoice,
                  colorFilter:
                      ColorFilter.mode(AppColors.color2E236C, BlendMode.srcIn),
                  matchTextDirection: true,
                ),
              ),
            ),
            Gap(12.0),
            Text(
              '${'Order ID'.tr} : ',
              style: mullerW400.copyWith(
                  fontSize: 12, color: AppColors.color12658E),
            ),
            Text(
              '${invoice.orderId ?? ''}',
              style: mullerW500.copyWith(
                  fontSize: 14, color: AppColors.color171236),
            ),
            Text(
              invoice.created.formatDDMMYYYY(),
              style: mullerW400.copyWith(
                  fontSize: 12, color: AppColors.color12658E),
            ),
            Gap(12.0),
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: Utility.getOrderStatusColor(invoice.orderStatus),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  invoice.orderStatus?.title ?? '',
                  style:
                      mullerW500.copyWith(fontSize: 12, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
