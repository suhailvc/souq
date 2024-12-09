import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/home_square_icons_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductManagementWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.colorB1D2E3,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.colorB1D2E3,
                ),
              ),
            ),
            child: Text(
              'Product Management'.tr,
              style: mullerW500.copyWith(
                  fontSize: 16, color: AppColors.color1D1D1D),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _getProductManagementOption(
                title: 'Add New'.tr,
                iconName: Assets.svg.icAddNew,
                onTap: () {
                  Get.toNamed(RouteHelper.addNewProduct);
                },
              ),
              VerticalDividerWidget(
                height: 57,
                color: AppColors.colorB1D2E3,
              ),
              _getProductManagementOption(
                title: 'Search'.tr,
                iconName: Assets.svg.icSearch,
                onTap: () {
                  Get.toNamed(RouteHelper.productList);
                },
              ),
              VerticalDividerWidget(
                height: 57,
                color: AppColors.colorB1D2E3,
              ),
              _getProductManagementOption(
                title: 'View All'.tr,
                iconName: Assets.svg.icRightArrowRound,
                onTap: () {
                  Get.toNamed(RouteHelper.productList);
                },
              ),
            ],
          ).paddingSymmetric(vertical: 16.0),
        ],
      ),
    );
  }

  Widget _getProductManagementOption(
      {required final String title,
      required final String iconName,
      required final VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          HomeSquareIconsWidget(
            iconName: iconName,
          ),
          Gap(11.0),
          Text(
            title,
            style:
                mullerW500.copyWith(fontSize: 14, color: AppColors.color1D1D1D),
          ),
        ],
      ),
    );
  }
}
