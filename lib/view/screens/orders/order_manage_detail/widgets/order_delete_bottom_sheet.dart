import 'dart:ui';

import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDeleteBottomSheet extends StatelessWidget {
  const OrderDeleteBottomSheet({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
        initState: (final GetBuilderState<OrderDetailController> state) {
      Get.find<OrderDetailController>().txtCancelReason.text = '';
    }, builder: (final OrderDetailController controller) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.12),
                      blurRadius: 27.6,
                      spreadRadius: 0,
                      offset: Offset(0, -8),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Gap(24),
                    SvgPicture.asset(
                      Assets.svg.icDeleteBig,
                      width: 36,
                      height: 36,
                    ),
                    Gap(16),
                    Text(
                      'Are you sure you want to \n cancel this Order?'.tr,
                      textAlign: TextAlign.center,
                      style: mullerW400.copyWith(
                        color: AppColors.color171236,
                        fontSize: 18,
                      ),
                    ),
                    Gap(16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cancellation Reason'.tr,
                        style: mullerW400.copyWith(
                            fontSize: 12, color: AppColors.color12658E),
                      ).paddingSymmetric(horizontal: 16),
                    ),
                    Gap(5),
                    CommonTextField(
                      controller: controller.txtCancelReason,
                      textAlign: TextAlign.start,
                      minLines: 5,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      style: mullerW500,
                      labelText: '',
                    ),
                    Gap(16),
                    CommonButton(
                        backgroundColor: AppColors.colorE52551,
                        textStyle: mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                        onTap: () {
                          controller.onTapConfirmRejectOrder();
                        },
                        title: 'Yes, Cancel Order'.tr),
                    Gap(12),
                    CommonButton(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.color8ABCD5,
                          ),
                        ),
                        textStyle: mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.color12658E,
                        ),
                        onTap: () {
                          Get.back();
                        },
                        title: 'No, Don’t Cancel'.tr),
                    Gap(MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom
                        : 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  static void show() {
    Get.bottomSheet(
      OrderDeleteBottomSheet(),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }
}
