import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (final BuildContext context, final int index) {
        return Container(
          width: Get.width,
          margin: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 16.0,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Shimmer(
                          duration: const Duration(seconds: 1),
                          child: Container(
                            color: AppColors.screenBG,
                            height: 14.0,
                          ),
                        ),
                        const Gap(6),
                        Shimmer(
                          duration: const Duration(seconds: 1),
                          child: Container(
                            color: AppColors.screenBG,
                            height: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Shimmer(
                    duration: const Duration(seconds: 1),
                    child: Container(
                      color: AppColors.screenBG,
                      width: 36,
                      height: 36,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        );
      },
    );
  }
}
