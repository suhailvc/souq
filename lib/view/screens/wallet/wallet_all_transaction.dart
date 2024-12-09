import 'package:atobuy_vendor_flutter/controller/wallet/wallet_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_transactions_model.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/wallet/widgets/wallet_transaction_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WalletAllTransactionScreen extends StatelessWidget {
  const WalletAllTransactionScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        appBar: AppbarWithBackIconAndTitle(
          title: 'Payment History'.tr,
        ),
        body: SafeArea(
          child: GetBuilder<WalletController>(
              initState: (final GetBuilderState<WalletController> state) {
            Get.find<WalletController>().setPageControllerListener();
          }, builder: (final WalletController controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gap(16),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.refreshTransactions,
                    child: PagedListView<int, WalletTransaction>.separated(
                      pagingController: controller.allWalletTransactionList,
                      builderDelegate:
                          PagedChildBuilderDelegate<WalletTransaction>(
                        itemBuilder: (final BuildContext context,
                                final WalletTransaction item,
                                final int index) =>
                            WalletTransactionRow(
                          transaction: item,
                        ),
                        firstPageErrorIndicatorBuilder:
                            (final BuildContext context) {
                          return NoItemFoundWidget(
                            image: '',
                            message: 'No transaction found!'.tr,
                          );
                        },
                        noItemsFoundIndicatorBuilder:
                            (final BuildContext context) {
                          return NoItemFoundWidget(
                            image: '',
                            message: 'No transaction found!'.tr,
                          );
                        },
                      ),
                      separatorBuilder:
                          (final BuildContext context, final int index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.0);
          }),
        ),
      ),
    );
  }
}
