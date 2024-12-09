import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TitleWithBulletAndDividerWidget extends StatelessWidget {
  const TitleWithBulletAndDividerWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Gap(16),
        Container(
          height: 8,
          width: 8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.color1679AB,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Gap(8),
        Text(
          title,
          style: mullerW400.copyWith(
            fontSize: 12,
            color: AppColors.color1679AB,
          ),
        ),
        Gap(8),
        Expanded(
          child: Divider(
            color: AppColors.colorB1D2E3,
          ),
        ),
      ],
    );
  }
}
