import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ItemWithIconTitleAndRightIconWidget extends StatelessWidget {
  const ItemWithIconTitleAndRightIconWidget({
    super.key,
    required this.title,
    required this.prefixSvgIcon,
    required this.onTap,
  });

  final String title;
  final String prefixSvgIcon;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.colorB1D2E3,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              prefixSvgIcon,
              width: 30,
              height: 30,
              matchTextDirection: true,
            ),
            Gap(12),
            Expanded(
              child: Text(
                title,
                style: mullerW500.copyWith(
                  fontSize: 16,
                  color: AppColors.color1D1D1D,
                ),
              ),
            ),
            Gap(12),
            SvgPicture.asset(
              Assets.svg.icRightArrowRound,
              width: 14,
              height: 14,
              matchTextDirection: true,
              colorFilter:
                  ColorFilter.mode(AppColors.color1679AB, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
