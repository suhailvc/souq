import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileScreenOptionsWidget extends StatelessWidget {
  const ProfileScreenOptionsWidget(
      {super.key,
      required this.svgImage,
      required this.optionTitle,
      required this.onTap});

  final String svgImage;
  final String optionTitle;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
              color: (optionTitle == 'Logout'.tr)
                  ? Colors.transparent
                  : AppColors.colorB1D2E3,
              width: (optionTitle == 'Logout'.tr) ? 0 : 1),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              svgImage,
              height: 22,
              width: 22,
              matchTextDirection: true,
              colorFilter: ColorFilter.mode(
                  (optionTitle == 'Logout'.tr)
                      ? AppColors.colorEC1C50
                      : AppColors.color1D1D1D,
                  BlendMode.srcIn),
            ),
            Gap(12.75),
            Text(
              optionTitle,
              style: mullerW400.copyWith(
                  fontSize: 16,
                  color: (optionTitle == 'Logout'.tr)
                      ? AppColors.colorEC1C50
                      : AppColors.color1D1D1D),
            ),
            Spacer(),
            Visibility(
              visible: (optionTitle != 'Logout'.tr),
              child: SvgPicture.asset(
                Assets.svg.icRightArrow,
                matchTextDirection: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
