import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartRepo {
  CartRepo(this.dioClient);
  final DioClient dioClient;

  Future<CartModel> getCartList(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient.get(
        Endpoints.cart,
        queryParameters: params,
      );
      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> updateCart({required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient.post(
        Endpoints.cart,
        data: params,
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> updateCartWithQuantity(
      {required final Map<String, dynamic> params,
      required final String cartId}) async {
    try {
      final Response<dynamic> response = await dioClient.patch(
        '${Endpoints.cart}$cartId/',
        data: params,
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> decreaseQty(
      {required final Map<String, dynamic> params,
      required final int cartId}) async {
    try {
      final Response<dynamic> response = await dioClient.patch(
        '${Endpoints.cart}$cartId/',
        data: params,
      );
      return response.data;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> deleteItemFromCart({
    required final Map<String, dynamic> params,
    required final int cartId,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.delete('${Endpoints.cart}$cartId/', data: params);
      return response.data;
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

  Future<AddressListModel> getShippingAddress() async {
    try {
      final Response<dynamic> response = await dioClient.get(
        Endpoints.address,
      );
      return AddressListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<OrderDetailsModel> buyProduct(
      {required final Map<String, dynamic> body}) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.order, data: body);
      return OrderDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
