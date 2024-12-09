import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_balance_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_transactions_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WalletRepo {
  WalletRepo({required this.dioClient});

  DioClient dioClient;
  Future<WalletBalanceModel> getWalletBalance() async {
    try {
      final Response<dynamic> response = await dioClient.get(
        Endpoints.walletBalance,
      );
      return WalletBalanceModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WalletTransactionsModel> getWalletTransactions(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.walletHistory, queryParameters: queryParams);
      return WalletTransactionsModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
