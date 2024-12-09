import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDownloadInvoice extends StatelessWidget {
  const OrderDownloadInvoice({super.key, required this.onTapDownload});

  final VoidCallback onTapDownload;
  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap(16),
        Text(
          'Invoice'.tr,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
        ),
        Gap(8.0),
        GestureDetector(
          onTap: onTapDownload,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              border: Border.all(color: AppColors.colorB1D2E3, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(Assets.svg.icDownload),
                Gap(12),
                Text(
                  'Click here to Download Invoice'.tr,
                  style: mullerW500.copyWith(
                      fontSize: 16, color: AppColors.color2E236C),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
