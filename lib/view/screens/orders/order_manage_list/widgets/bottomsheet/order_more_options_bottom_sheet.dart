import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderMoreOptionsBottomSheet extends StatelessWidget {
  const OrderMoreOptionsBottomSheet(
      {super.key, required this.onTapDownloadInvoice});
  final VoidCallback onTapDownloadInvoice;
  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.black.withOpacity(0.12),
                blurRadius: 27.6,
                spreadRadius: 0,
                offset: Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Gap(24),
              GestureDetector(
                onTap: () {
                  //Download invoice action
                  Get.back(); //Temp action
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorB1D2E3, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(Assets.svg.icDownload),
                      Gap(12),
                      Text(
                        'Download Invoice'.tr,
                        style: mullerW500.copyWith(
                            fontSize: 16, color: AppColors.color2E236C),
                      ),
                      Spacer(),
                      SvgPicture.asset(Assets.svg.icRightArrowRound),
                    ],
                  ),
                ),
              ),
              Gap(34),
            ],
          ),
        ),
      ],
    );
  }
}
