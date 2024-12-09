import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/home/order_stats_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  HomeRepo({required this.sharedPreferences, required this.apiClient});

  DioClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<OrderStatsModel> getOrderStatistics(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await apiClient.get(
        Endpoints.orderStats,
        queryParameters: params,
      );
      return OrderStatsModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
