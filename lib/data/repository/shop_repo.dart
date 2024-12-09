import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/vendor_store_exist_response_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/promo_banner/banner_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/store/offert_type_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShopRepo {
  ShopRepo(this._dioClient);
  final DioClient _dioClient;

  Future<List<Category>> getCategories(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.category,
        queryParameters: queryParams,
      );
      if (response.data is List) {
        return (response.data as List<dynamic>)
            .map((final dynamic e) => Category.fromJson(e))
            .toList();
      } else {
        return <Category>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductListModel> getProduct(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await _dioClient.get(Endpoints.products, queryParameters: params);
      return ProductListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<VendorStoreExistResponseModel> getVendorStoreCreatedStatus({
    required final int userId,
  }) async {
    try {
      final Response<dynamic> response =
          await _dioClient.get('${Endpoints.users}$userId/store-exist/');
      return VendorStoreExistResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Category>> getSubCategories(
      {required final String categoryId}) async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        '${Endpoints.category}$categoryId/sub_category/',
      );
      if (response.data is List) {
        return (response.data as List<dynamic>)
            .map((final dynamic e) => Category.fromJson(e))
            .toList();
      } else {
        return <Category>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<OfferTypeListModel> getOfferTypeList() async {
    try {
      final Response<dynamic> response = await _dioClient.get(
        Endpoints.getOfferTypeList,
      );
      return OfferTypeListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<BannerItem>> getAllBannerList(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await _dioClient
          .get(Endpoints.getStoreBannerList, queryParameters: params);
      if (response.data is List) {
        final List<BannerItem> list = (response.data as List<dynamic>)
            .map((final dynamic e) => BannerItem.fromJson(e))
            .toList();

        return list;
      } else {
        return <BannerItem>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
