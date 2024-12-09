import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/select_store/store_list_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreListScreen extends StatelessWidget {
  const StoreListScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GetBuilder<UserProfileController>(
        initState: (final GetBuilderState<UserProfileController> state) {
          Get.find<UserProfileController>().initialiseStoreScreen();
        },
        builder: (final UserProfileController controller) {
          return Scaffold(
            appBar: AppbarWithBackIconAndTitle(
              title: 'My Stores'.tr,
            ),
            body: Column(
              children: <Widget>[
                Gap(10.0),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.arrStores.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 109 / 130,
                    ),
                    itemBuilder: (final BuildContext context, final int index) {
                      return StoreListCell(
                        onSelectStore: () {
                          controller.onTapSelectStore(
                            store: controller.arrStores[index],
                          );
                        },
                        store: controller.arrStores[index],
                        isSelected: controller.arrStores[index].id ==
                            controller.selectedStore?.id,
                      );
                    },
                  ),
                ),
                Gap(10),
                CommonButton(
                    onTap: () {
                      controller.onTapSaveSelectedStore();
                    },
                    title: 'Continue'.tr),
                Gap(MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 16),
              ],
            ).paddingSymmetric(horizontal: 16),
          );
        },
      ),
    );
  }
}
