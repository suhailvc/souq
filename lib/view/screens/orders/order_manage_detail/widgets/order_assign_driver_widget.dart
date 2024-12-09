import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderAssignDriverWidget extends StatelessWidget {
  const OrderAssignDriverWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
        builder: (final OrderDetailController controller) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.assignDriver);
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12.0),
          color: AppColors.color3D8FB9,
          strokeWidth: 2,
          dashPattern: <double>[4, 6],
          padding: EdgeInsets.zero,
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 95,
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(Assets.svg.icDriver),
                  Gap(12.0),
                  Text(
                    'Tap here to assign a driver'.tr,
                    style: mullerW400.copyWith(
                        fontSize: 12,
                        color: AppColors.color1679AB.withOpacity(0.5)),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
