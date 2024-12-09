import 'package:atobuy_vendor_flutter/controller/shop_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_bottombar.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/business_category_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/buy_now_top_navigation_bar_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/offer_banner.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/store_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GetBuilder<ShopController>(
        initState: (final GetBuilderState<ShopController> state) {
          Get.find<ShopController>().init();
        },
        builder: (final ShopController controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Gap(10.0),
                  BuyNowNavigationBarWidget(
                    sharedPreferenceHelper: controller.sharedPref,
                  ),
                  Gap(16.0),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.searchProductList,
                        preventDuplicates: false),
                    child: SizedBox(
                      height: 40,
                      child: CommonTextField(
                        labelText: 'Search'.tr,
                        enabled: false,
                        labelStyle: mullerW500.copyWith(
                            fontSize: 16, color: AppColors.colorB1D2E3),
                        controller: TextEditingController(),
                        prefixIcon: SvgPicture.asset(
                          Assets.svg.icSearch,
                          matchTextDirection: true,
                        ),
                        textInputAction: TextInputAction.done,
                      ).paddingSymmetric(horizontal: 16.0),
                    ),
                  ),
                  Gap(20.0),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.refreshData(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            OfferBanner(),
                            Gap(16.0),
                            BusinessCategoryWidget(),
                            Gap(16.0),
                            StoreCategoryWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentSelectedIndex: 1,
              isStoreCreated: Get.find<ShopController>()
                      .sharedPref
                      .user
                      ?.vendorStoreExist ??
                  false,
            ),
          );
        },
      ),
    );
  }
}
