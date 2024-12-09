import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommonDeleteBottomSheet extends StatelessWidget {
  const CommonDeleteBottomSheet(
      {super.key,
      required this.onTapDelete,
      required this.title,
      required this.subTitle});

  final String title;
  final String subTitle;
  final VoidCallback onTapDelete;
  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
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
              const Gap(8.0),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(Assets.svg.icBottomSheetLine),
              ),
              const Gap(38.0),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(
                    Assets.svg.icDeleteBig,
                    matchTextDirection: true,
                  ),
                ),
              ),
              const Gap(24.0),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: mullerW700.copyWith(
                      color: AppColors.color033E54, fontSize: 22.0),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: mullerW500.copyWith(
                      color: AppColors.color033E54, fontSize: 14),
                ),
              ),
              const Gap(24.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CommonButton(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        Get.back();
                      },
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.color8ABCD5,
                          width: 1,
                        ),
                      ),
                      titleColor: AppColors.color033E54,
                      title: 'Cancel'.tr,
                    ),
                  ),
                  Expanded(
                    child: CommonButton(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        onTap: () {
                          Get.back();
                          onTapDelete.call();
                        },
                        title: 'Delete'.tr),
                  ),
                ],
              ),
              const Gap(36.0),
            ],
          ),
        ),
      ],
    );
  }
}
