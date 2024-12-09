import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet(
      {super.key, required this.onTapContinue, required this.title});

  final VoidCallback onTapContinue;
  final String title;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Gap(35),
              SvgPicture.asset(Assets.svg.icAccountCreated),
              Gap(43),
              Text(
                title,
                textAlign: TextAlign.center,
                style: mullerW700.copyWith(
                    fontSize: 20, color: AppColors.color2E236C),
              ),
              Gap(58),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  child: Text(
                    'Continue'.tr,
                    style: mullerW500.copyWith(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    onTapContinue();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.color12658E,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    elevation: 5,
                    shadowColor: AppColors.black,
                  ),
                ),
              ),
              Gap(48),
            ],
          ),
        ),
      ],
    );
  }

  static void show(
      {required final VoidCallback onTapContinue,
      required final String title}) {
    Get.bottomSheet(
      SuccessBottomSheet(
        onTapContinue: onTapContinue,
        title: title,
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
      isDismissible: false,
      enableDrag: false,
    );
  }
}
