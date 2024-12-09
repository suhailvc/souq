import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GlobalRepository {
  GlobalRepository({required this.dioClient});

  // dio instance
  final DioClient dioClient;

  Future<List<CountryModel>> getCountryList(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.getCountryList, queryParameters: queryParams);
      if (response.data is List) {
        return (response.data as List<dynamic>)
            .map((final dynamic e) => CountryModel.fromJson(e))
            .toList();
      } else {
        return <CountryModel>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Region>> getStates(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.getStateList, queryParameters: queryParams);
      if (response.data is List) {
        return (response.data as List<dynamic>)
            .map((final dynamic e) => Region.fromJson(e))
            .toList();
      } else {
        return <Region>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<City>> getCity(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.getCityList, queryParameters: queryParams);
      if (response.data is List) {
        return (response.data as List<dynamic>)
            .map((final dynamic e) => City.fromJson(e))
            .toList();
      } else {
        return <City>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductFilter> getProductFilterData(
      {required final Map<String, String> queryParams}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.category, queryParameters: queryParams);
      return ProductFilter.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<BusinessCategory>> getBusinessCategory(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.getBusinessCategory, queryParameters: queryParams);

      if (response.data is List) {
        return (response.data as List<dynamic>)
            .map((final dynamic e) => BusinessCategory.fromJson(e))
            .toList();
      } else {
        return <BusinessCategory>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<PaymentMethodModel> getPaymentMethods() async {
    try {
      final Response<dynamic> response = await dioClient.get(
        Endpoints.paymentList,
      );
      return PaymentMethodModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> updateFCMToken({required final String fcmToken}) async {
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'registration_id': fcmToken,
        'active': true,
      });
      final Response<dynamic> response = await dioClient.post(
        Endpoints.updateFCMToken,
        data: formData,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<BrandListResponseModel> getBrandList(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.getBrands, queryParameters: queryParams);
      return BrandListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
