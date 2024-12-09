import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({super.key, required this.height, this.color});

  final double height;
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 1.0,
      height: height,
      color: color ?? AppColors.color3D8FB9.withOpacity(0.26),
    );
  }
}
