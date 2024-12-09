import 'package:atobuy_vendor_flutter/data/repository/wallet_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_balance_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_transactions_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WalletController extends GetxController {
  WalletController({required this.walletRepo});

  PagingController<int, WalletTransaction> allWalletTransactionList =
      PagingController<int, WalletTransaction>(
          firstPageKey: 1, invisibleItemsThreshold: 1);
  List<WalletTransaction> arrRecentTransaction = <WalletTransaction>[];

  final WalletRepo walletRepo;
  WalletBalanceModel? walletBalance;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getWalletBalance();
    getWalletTransactions(page: 1);
  }

  void setPageControllerListener() {
    allWalletTransactionList.dispose();
    allWalletTransactionList =
        PagingController<int, WalletTransaction>(firstPageKey: 1);
    allWalletTransactionList.addPageRequestListener((final int pageKey) {
      getWalletTransactions(page: pageKey);
    });
  }

  Future<void> refreshData() async {
    getWalletBalance();
    getWalletTransactions(page: 1);
    refreshTransactions();
  }

  Future<void> refreshTransactions() async {
    allWalletTransactionList.refresh();
  }

  Future<void> getWalletBalance() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      walletBalance = await walletRepo.getWalletBalance();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getWalletTransactions({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final WalletTransactionsModel value = await walletRepo
          .getWalletTransactions(queryParams: <String, dynamic>{'page': page});
      isLoading = false;
      if (page == 1) {
        arrRecentTransaction = <WalletTransaction>[];
        arrRecentTransaction = value.results ?? <WalletTransaction>[];
      }
      if (value.next != null) {
        final int nextPage = page + 1;
        allWalletTransactionList.appendPage(
            value.results ?? <WalletTransaction>[], nextPage);
      } else {
        allWalletTransactionList
            .appendLastPage(value.results ?? <WalletTransaction>[]);
      }
      update();
    } catch (e) {
      isLoading = false;
      debugPrint(e.toString());
      update();
    }
  }
}
