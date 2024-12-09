import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSquareIconsWidget extends StatelessWidget {
  const HomeSquareIconsWidget({super.key, required this.iconName, this.size});

  final String iconName;
  final double? size;
  @override
  Widget build(final BuildContext context) {
    return Container(
      height: size ?? 32,
      width: size ?? 32,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.colorD0E4EE,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.colorB1D2E3),
      ),
      child: SvgPicture.asset(
        iconName,
        matchTextDirection: true,
        colorFilter: ColorFilter.mode(AppColors.color1679AB, BlendMode.srcIn),
      ),
    );
  }
}
