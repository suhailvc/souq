import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ErrorInfoView extends GetWidget<LoginController> {
  const ErrorInfoView({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.colorFDECF0,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(Assets.svg.icInfoRed),
          Gap(8),
          Expanded(
            child: Text(
              message,
              style: mullerW400.copyWith(color: AppColors.colorEA2251),
            ),
          ),
        ],
      ),
    );
  }
}
