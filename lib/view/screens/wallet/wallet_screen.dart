import 'package:atobuy_vendor_flutter/controller/wallet/wallet_controller.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_bottombar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/wallet/widgets/recent_activity_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/wallet/widgets/wallet_top_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        appBar: AppbarWithTitle(
          title: 'My Wallet'.tr,
        ),
        body: SafeArea(
          child: GetBuilder<WalletController>(
              builder: (final WalletController controller) {
            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(16),
                  WalletTopView(),
                  Gap(32),
                  Expanded(
                    child: controller.arrRecentTransaction.isNotEmpty
                        ? ResentActivityList()
                        : controller.isLoading
                            ? SizedBox()
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    NoItemFoundWidget(
                                      image: '',
                                      message: 'No transaction found!'.tr,
                                    ),
                                  ],
                                ),
                              ),
                  )
                ],
              ).paddingSymmetric(horizontal: 16.0),
            );
          }),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentSelectedIndex: 2,
          isStoreCreated:
              Get.find<SharedPreferenceHelper>().user?.vendorStoreExist ??
                  false,
        ),
      ),
    );
  }
}
