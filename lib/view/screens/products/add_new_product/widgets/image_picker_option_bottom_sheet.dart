import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommonBottomSheet extends StatelessWidget {
  CommonBottomSheet({
    required this.onTapCamera,
    required this.onTapGallery,
  });

  final Function() onTapCamera;
  final Function() onTapGallery;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Gap(20.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Select Any option'.tr,
                  style: mullerW500.copyWith(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const Gap(30.0),
              CommonButton(
                backgroundColor: AppColors.colorDFE6E9,
                onTap: () {
                  Utility.goBack();
                  onTapCamera.call();
                },
                title: 'Camera'.tr,
                titleColor: AppColors.color2E236C,
              ),
              const Gap(20.0),
              CommonButton(
                onTap: () {
                  Utility.goBack();
                  onTapGallery.call();
                },
                title: 'Gallery'.tr,
              ),
              const Gap(30.0),
            ],
          ),
        ),
      ],
    );
  }
}
