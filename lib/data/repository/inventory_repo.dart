import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InventoryRepo {
  InventoryRepo({required this.dioClient});

  DioClient dioClient;

  Future<InventoryListResponseModel> getInventoryList(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.getStoreList, queryParameters: params);
      return InventoryListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<InventoryDetailsModel> getInventoryDetails(
      {required final String storeUUID,
      required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get('${Endpoints.getStoreList}$storeUUID/', queryParameters: params);
      return InventoryDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
