import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommonImagePlaceholderWidget extends StatelessWidget {
  const CommonImagePlaceholderWidget({
    super.key,
    this.padding,
    this.borderRadius,
    this.border,
    this.backgroundColor,
  });

  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white.withOpacity(0.00),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: border),
      child: Assets.images.splashLogo.image(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        color: AppColors.color3D8FB9.withOpacity(0.6),
      ),
    );
  }
}

class CommonImagePlaceholderImage extends StatelessWidget {
  const CommonImagePlaceholderImage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Image(
      color: AppColors.color3D8FB9.withOpacity(0.6),
      image: Assets.images.splashLogo.provider(),
    );
  }
}
