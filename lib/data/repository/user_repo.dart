import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/create_user_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/login_reponse_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/user_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/user_response_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class UserRepo {
  UserRepo({required this.dioClient});

  DioClient dioClient;

  Future<UserResponseModel> getUserProfile() async {
    try {
      final Response<dynamic> response = await dioClient.get(
        Endpoints.users,
      );
      return UserResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<UserModel> editUserProfile(
      {required final int userId,
      final String? type,
      required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient.patch(
        '${Endpoints.users}$userId/${type ?? ''}',
        data: FormData.fromMap(params),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<AddressListModel> getAddresses(
      {required final Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dioClient.get(
        Endpoints.address,
        queryParameters: params,
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

  Future<LoginUserResponse> verifyOTPRequest({
    required final Map<String, dynamic> body,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient
          .post(Endpoints.verifyOTP, data: body, queryParameters: queryParams);
      final LoginUserResponse loginResponse =
          LoginUserResponse.fromJson(response.data);

      return loginResponse;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> resendOTP({
    required final Map<String, dynamic> body,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.get(Endpoints.sendOTP,
          queryParameters: queryParams, data: body);
      return response.statusCode == 200;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> sendOTPForEmailVerification({
    required final Map<String, dynamic> body,
    required final Map<String, dynamic> queryParams,
  }) async {
    try {
      final Response<dynamic> response = await dioClient.get(Endpoints.sendOTP,
          data: body, queryParameters: queryParams);
      return response.statusCode == 200;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> changePassword({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.changePassword, data: body);
      final CreateUserModel responseModel =
          CreateUserModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (responseModel.detail.isNotNullAndEmpty()) {
          showCustomSnackBar(
              isError: false, message: 'New password has been saved.'.tr);
        }
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> createUpdateAddresses(
      {required final Map<String, dynamic> body}) async {
    try {
      Response<dynamic> response;
      if (body['id'] == null) {
        response = await dioClient.post(Endpoints.address, data: body);
      } else {
        final int id = body['id'];
        response =
            await dioClient.patch('${Endpoints.address}/$id/', data: body);
      }

      return response.data;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> deleteAddressApiCall({required final int addressId}) async {
    try {
      final Response<dynamic> response = await dioClient.delete(
        '${Endpoints.address}$addressId/',
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

  Future<dynamic> deleteUserAccount() async {
    try {
      final Response<dynamic> response = await dioClient.delete(
        Endpoints.deleteAccount,
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
}
