import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/common/common_detail_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/driver_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderRepo {
  OrderRepo({required this.dioClient});

  DioClient dioClient;

  Future<OrderListModel> getOrderList(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.order, queryParameters: params);
      return OrderListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<OrderDetailsModel> getOrderDetails(
      {required final String orderId,
      required final Map<String, dynamic> param}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get('${Endpoints.order}$orderId/', queryParameters: param);
      return OrderDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<DriverListModel> getDriverList(
      {required final Map<String, dynamic> queryParameter}) async {
    try {
      final Response<dynamic> response = await dioClient.get(Endpoints.driver,
          queryParameters: queryParameter);
      return DriverListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<CommonDetailModel> commonOrderDetailsApi({
    required final OrderDetailsCommonAPIType apiType,
    required final String orderId,
    required final Map<String, dynamic> body,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      String apiEndPoint = '$orderId/';
      switch (apiType) {
        case OrderDetailsCommonAPIType.assignDriver:
          apiEndPoint = apiEndPoint + Endpoints.assignDriver;
        case OrderDetailsCommonAPIType.acceptRejectOrder:
          apiEndPoint = apiEndPoint + Endpoints.acceptRejectOrder;
      }
      final Response<dynamic> response = await dioClient.patch(
          '${Endpoints.order}$apiEndPoint',
          data: body,
          queryParameters: queryParams);
      return CommonDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<CommonDetailModel> completeOrder({
    required final String orderId,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.patch(
          '${Endpoints.order}$orderId/complete-order/',
          queryParameters: queryParams);
      return CommonDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> contactUs({
    required final Map<String, dynamic> parameter,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.ticket, data: parameter);
      return response.data;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
