import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommonButtonWithImage extends StatelessWidget {
  const CommonButtonWithImage(
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
      this.suffixWidget,
      this.fontSize});

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
  final Widget? suffixWidget;
  final double? spaceBtWidgetandText;
  final Color? titleColor;
  final double? fontSize;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor ?? AppColors.color3D8FB9,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: mullerW700.copyWith(
                    color: titleColor ?? AppColors.white,
                    fontSize: fontSize ?? 16),
              ),
              Gap(10),
              suffixWidget ?? SizedBox(),
            ],
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
