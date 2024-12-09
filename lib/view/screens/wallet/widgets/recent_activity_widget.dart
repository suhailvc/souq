import 'package:atobuy_vendor_flutter/controller/wallet/wallet_controller.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/wallet/widgets/wallet_transaction_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResentActivityList extends StatelessWidget {
  const ResentActivityList({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (final WalletController controller) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Resent Activity'.tr,
                  style: mullerW500.copyWith(
                      fontSize: 16, color: AppColors.color1D1D1D),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.walletAllTransaction);
                  },
                  child: Visibility(
                    visible: controller.arrRecentTransaction.length >= 10,
                    child: Text(
                      'See All'.tr,
                      style: mullerW500.copyWith(
                        fontSize: 14,
                        color: AppColors.color3D8FB9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 16),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (final BuildContext context, final int index) {
                      return WalletTransactionRow(
                        transaction: controller.arrRecentTransaction[index],
                      );
                    },
                    separatorBuilder:
                        (final BuildContext context, final int index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                    itemCount: controller.arrRecentTransaction.length),
              ),
            ),
          ],
        );
      },
    );
  }
}
