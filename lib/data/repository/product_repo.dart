import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/common/common_detail_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/offer_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/purhcase/cart_item_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductRepo {
  ProductRepo({required this.dioClient});

  DioClient dioClient;

  Future<ProductListModel> getProduct(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.products, queryParameters: params);
      return ProductListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductListModel> getVendorsProduct(
      {required final String productUUID,
      required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient.get(
          '${Endpoints.products}$productUUID/vendor-products/',
          queryParameters: params);
      return ProductListModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<StoreModel>> getStoreList(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.getStoreList, queryParameters: params);
      if (response.data is List) {
        final List<StoreModel> list = (response.data as List<dynamic>)
            .map((final dynamic e) => StoreModel.fromJson(e))
            .toList();

        return list;
      } else {
        return <StoreModel>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> createNewProduct(
      {required final Map<String, dynamic> body}) async {
    try {
      final Response<dynamic> response = await dioClient
          .post(Endpoints.products, data: FormData.fromMap(body));

      if (response.statusCode == 201) {
        return response.data;
      } else {
        final String message =
            Map<dynamic, dynamic>.from(response.data).entries.first.value[0];
        final String? title = Map<dynamic, dynamic>.from(response.data)
            .entries
            .first
            .key
            .toString()
            .replaceAll('-', ' ');
        showCustomSnackBar(title: title, message: message);
        throw DioException;
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> updateProduct({
    required final Map<String, dynamic> body,
    required final String uuid,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.patch(
          '${Endpoints.products}$uuid/',
          data: FormData.fromMap(body),
          queryParameters: queryParams);

      return response.data;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductDetailsModel> getProductDetails(
      {required final String productUUID,
      required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get('${Endpoints.products}$productUUID/', queryParameters: params);
      return ProductDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProductDetailsModel> updateProductStatus({
    required final String productUUID,
    required final Map<String, dynamic> body,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.patch(
          '${Endpoints.products}$productUUID/active-inactive-product/',
          data: body,
          queryParameters: queryParams);
      return ProductDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> deleteProduct({
    required final String productUUID,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.delete(
          '${Endpoints.products}$productUUID/',
          queryParameters: queryParams);
      if (response.statusCode == 204) {
        return true;
      } else {
        final String message =
            Map<dynamic, dynamic>.from(response.data).entries.first.value[0];
        final String? title = Map<dynamic, dynamic>.from(response.data)
            .entries
            .first
            .key
            .toString()
            .replaceAll('-', ' ');
        showCustomSnackBar(title: title, message: message);
        throw DioException;
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<CommonDetailModel> uploadProductListFile(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient.post(
        '${Endpoints.uploadProductsSheet}',
        data: FormData.fromMap(params),
      );
      return CommonDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<CartItemModel> addProductToCart(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.addToCart, data: params);
      return CartItemModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> createOrEditOffer(
      {required final Map<String, dynamic> body, final int? offerId}) async {
    try {
      Response<dynamic> response;

      if (offerId == null) {
        response = await dioClient.post(Endpoints.offers,
            data: FormData.fromMap(body));
        if (response.statusCode == 201) {
          return response.data;
        } else {
          final String message =
              Map<dynamic, dynamic>.from(response.data).entries.first.value[0];
          final String? title = Map<dynamic, dynamic>.from(response.data)
              .entries
              .first
              .key
              .toString()
              .replaceAll('-', ' ');
          showCustomSnackBar(title: title, message: message);
          throw DioException;
        }
      } else {
        response = await dioClient.patch('${Endpoints.offers}$offerId/',
            data: FormData.fromMap(body));
        return response.data;
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<ProductOffer>> getOfferList(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.offers, queryParameters: params);
      if (response.data is List) {
        final List<ProductOffer> list = (response.data as List<dynamic>)
            .map((final dynamic e) => ProductOffer.fromJson(e))
            .toList();

        return list;
      } else {
        return <ProductOffer>[];
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteOffer({required final String offerId}) async {
    try {
      final Response<dynamic> response =
          await dioClient.delete('${Endpoints.offers}$offerId/');
      return response.data;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Category>> getStoreCategoryList(
      {required final String storeUUID}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get('${Endpoints.getStoreCategory}$storeUUID/');
      if (response.data is List) {
        final List<Category> list = (response.data as List<dynamic>)
            .map((final dynamic e) => Category.fromJson(e))
            .toList();
        return list;
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

  Future<List<Category>> getStoreSubCategoryList(
      {required final int categoryId}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get('${Endpoints.category}$categoryId/sub_category/');
      if (response.data is List) {
        final List<Category> list = (response.data as List<dynamic>)
            .map((final dynamic e) => Category.fromJson(e))
            .toList();
        return list;
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
}
