import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.hasShadow = true,
      this.backgroundColor,
      this.decoration,
      this.height,
      this.width,
      this.margin,
      this.borderRadius,
      this.prefixWidget,
      this.spaceBtWidgetandText,
      this.titleColor,
      this.textStyle});

  final VoidCallback onTap;
  final String title;
  final bool hasShadow;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsets? margin;

  final Widget? prefixWidget;
  final double? spaceBtWidgetandText;
  final Color? titleColor;

  final TextStyle? textStyle;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor ?? AppColors.color12658E,
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: hasShadow
                      ? AppColors.color3D8FB9.withOpacity(0.15)
                      : Colors.transparent,
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 12),
                )
              ],
            ),
        height: height ?? 50,
        width: width ?? Get.width,
        margin: margin ?? EdgeInsets.zero,
        child: TextButton(
          child: Text(
            title,
            style: textStyle ??
                mullerW700.copyWith(
                    color: titleColor ?? AppColors.white, fontSize: 16),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
