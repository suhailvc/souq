import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_button_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DownloadInvoiceWidget extends StatelessWidget {
  const DownloadInvoiceWidget({super.key, required this.onTapDownloadInvoice});

  final VoidCallback onTapDownloadInvoice;
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: 238,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 16),
            height: 219,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.colorB1D2E3),
            ),
            child: Assets.images.imgInvoiceSmaple.image(),
          ),
          Positioned(
            bottom: 0,
            left: 82,
            right: 82,
            child: CommonButtonWithImage(
              height: 38,
              onTap: onTapDownloadInvoice,
              title: 'Download Invoice'.tr,
              backgroundColor: AppColors.color12658E,
              fontSize: 12,
              suffixWidget: SvgPicture.asset(
                Assets.svg.icDownloadWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}
