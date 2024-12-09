import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    super.key,
    this.currentSelectedIndex = 0,
    this.isStoreCreated = false,
  });

  final int currentSelectedIndex;
  final bool isStoreCreated;

  @override
  Widget build(final BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          color: AppColors.color2E236C,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isStoreCreated)
              GestureDetector(
                onTap: () {
                  if (Get.currentRoute != RouteHelper.home) {
                    Utility.isUserLoggedIn(
                      routeName: RouteHelper.home,
                      isTab: true,
                    );
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        currentSelectedIndex == 0
                            ? Assets.svg.icHomeSelected
                            : Assets.svg.icHomeUnselected,
                        height: 22,
                        width: 22,
                        colorFilter: ColorFilter.mode(
                            currentSelectedIndex == 0
                                ? AppColors.white
                                : AppColors.colorB9B6CE,
                            BlendMode.srcIn),
                      ),
                      Gap(12),
                      Text(
                        'Dashboard'.tr,
                        style: mullerW400.copyWith(
                          color: currentSelectedIndex == 0
                              ? AppColors.white
                              : AppColors.colorB9B6CE,
                          fontWeight: currentSelectedIndex == 0
                              ? FontWeight.w500
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                if (Get.currentRoute != RouteHelper.shop) {
                  Get.offAllNamed(
                    RouteHelper.shop,
                  );
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      currentSelectedIndex == 1
                          ? Assets.svg.icShopSelected
                          : Assets.svg.icShopUnselected,
                      height: 26,
                      width: 26,
                      colorFilter: ColorFilter.mode(
                          currentSelectedIndex == 1
                              ? AppColors.white
                              : AppColors.colorB9B6CE,
                          BlendMode.srcIn),
                    ),
                    Gap(8),
                    Text(
                      'Buy Now'.tr,
                      style: mullerW400.copyWith(
                        color: currentSelectedIndex == 1
                            ? AppColors.white
                            : AppColors.colorB9B6CE,
                        fontWeight: currentSelectedIndex == 1
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Get.currentRoute != RouteHelper.wallet) {
                  Utility.isUserLoggedIn(
                    routeName: RouteHelper.wallet,
                    isTab: true,
                  );
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      currentSelectedIndex == 2
                          ? Assets.svg.icWalletSelected
                          : Assets.svg.icWalletUnselected,
                      height: 26,
                      width: 26,
                      colorFilter: ColorFilter.mode(
                          currentSelectedIndex == 2
                              ? AppColors.white
                              : AppColors.colorB9B6CE,
                          BlendMode.srcIn),
                    ),
                    Gap(8),
                    Text(
                      'Wallet'.tr,
                      style: mullerW400.copyWith(
                        color: currentSelectedIndex == 2
                            ? AppColors.white
                            : AppColors.colorB9B6CE,
                        fontWeight: currentSelectedIndex == 2
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (Get.currentRoute != RouteHelper.profile) {
                  Get.offAllNamed(
                    RouteHelper.profile,
                  );
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      currentSelectedIndex == 3
                          ? Assets.svg.icProfileSelected
                          : Assets.svg.icProfileUnselected,
                      height: 26,
                      width: 26,
                      colorFilter: ColorFilter.mode(
                          currentSelectedIndex == 3
                              ? AppColors.white
                              : AppColors.colorB9B6CE,
                          BlendMode.srcIn),
                    ),
                    Gap(8),
                    Text(
                      'Profile'.tr,
                      style: mullerW400.copyWith(
                        color: currentSelectedIndex == 3
                            ? AppColors.white
                            : AppColors.colorB9B6CE,
                        fontWeight: currentSelectedIndex == 3
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
