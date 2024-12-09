import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginTab extends StatelessWidget {
  const LoginTab(
      {super.key, required this.onSelectTab, required this.selectedTab});

  final Function(SelectedLoginType) onSelectTab;
  final SelectedLoginType selectedTab;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColors.colorF5F5F5,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                onSelectTab.call(SelectedLoginType.email);
              },
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: selectedTab == SelectedLoginType.email
                      ? AppColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    'Login With Email'.tr,
                    style: selectedTab == SelectedLoginType.email
                        ? mullerW500.copyWith(color: AppColors.color16171B)
                        : mullerW400.copyWith(color: AppColors.color6A6982),
                  ),
                ),
              ),
            ),
          ),
          Gap(10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onSelectTab.call(SelectedLoginType.mobile);
              },
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: selectedTab == SelectedLoginType.mobile
                      ? AppColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    'Login With Mobile'.tr,
                    style: selectedTab == SelectedLoginType.mobile
                        ? mullerW500.copyWith(color: AppColors.color16171B)
                        : mullerW400.copyWith(color: AppColors.color6A6982),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
