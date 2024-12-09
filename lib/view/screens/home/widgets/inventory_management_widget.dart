import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/home_square_icons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ManagementWidget extends StatelessWidget {
  const ManagementWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onTap});

  final String image;
  final String title;
  final String subTitle;
  final Function() onTap;
  @override
  Widget build(final BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.colorB1D2E3,
          ),
        ),
        child: Row(
          children: <Widget>[
            HomeSquareIconsWidget(
              size: 30,
              iconName: image,
            ),
            Gap(8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: mullerW500.copyWith(
                        fontSize: 16, color: AppColors.color1D1D1D),
                  ),
                  Text(
                    subTitle,
                    style: mullerW400.copyWith(
                        fontSize: 12, color: AppColors.color757474),
                  )
                ],
              ),
            ),
            SvgPicture.asset(
              Assets.svg.icRightArrowRound,
              colorFilter:
                  ColorFilter.mode(AppColors.color1679AB, BlendMode.srcIn),
              matchTextDirection: true,
            ),
          ],
        ),
      ),
    );
  }
}
