import 'dart:ui';

import 'package:atobuy_vendor_flutter/controller/home_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_bottombar.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/date_picker.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/home_top_navigation_bar_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/inventory_management_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/order_management_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/order_stats_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/product_management_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<HomeController>(
              initState: (final GetBuilderState<HomeController> state) {
            Get.find<HomeController>().initialise();
          }, builder: (final HomeController controller) {
            return Column(
              children: <Widget>[
                Gap(10.0),
                HomeNavigationBarWidget(
                  sharedPreferenceHelper: controller.sharedPreferenceHelper,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Gap(16.0),
                        OrderStatsWidget(
                          onTapDate: () {
                            _openDatePicker();
                          },
                        ),
                        Gap(15.0),
                        ProductManagementWidget(),
                        Gap(16.0),
                        OrderManagementWidget(),
                        Gap(16.0),
                        ManagementWidget(
                          image: Assets.svg.icInventory,
                          title: 'Inventory Management'.tr,
                          subTitle: 'Take Control of your inventory'.tr,
                          onTap: () {
                            Get.toNamed(RouteHelper.inventoryList);
                          },
                        ),
                        Gap(16.0),
                        ManagementWidget(
                          image: Assets.svg.icInvoice,
                          title: 'Invoices Management'.tr,
                          subTitle: 'Generate & View Invoices'.tr,
                          onTap: () {
                            Get.toNamed(RouteHelper.invoiceList);
                          },
                        ),
                        Gap(16.0),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentSelectedIndex: 0,
          isStoreCreated: Get.find<HomeController>()
                  .sharedPreferenceHelper
                  .user
                  ?.vendorStoreExist ??
              false,
        ),
      ),
    );
  }

  void _openDatePicker() {
    Get.dialog(
      Dialog(
        elevation: 0,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SizedBox(
            height: Get.height * .5,
            width: Get.width,
            child: HomeAccountDatePicker(
              startDate: Get.find<HomeController>().filterModel.startDate,
              endDate: Get.find<HomeController>().filterModel.endDate,
              dateRangePickerView: DateRangePickerView.month,
              onSelectDate: (final DateRangePickerSelectionChangedArgs args) {
                Get.find<HomeController>().onSelectDate(args: args);
              },
            ),
          ),
        ),
      ),
    );
  }
}
