import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/login_reponse_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/common/common_detail_model.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gett;

class AuthRepo {
  AuthRepo({required this.sharedPreferences, required this.dioClient});
  DioClient dioClient;
  final SharedPreferenceHelper sharedPreferences;

  Future<LoginUserResponse> loginWithEmail({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response = await dioClient
          .post(Endpoints.emailLogin, data: FormData.fromMap(body));
      final LoginUserResponse responseModel =
          LoginUserResponse.fromJson(response.data);
      return responseModel;
    } on DioException catch (e) {
      Loader.load(false);
      Utility.showAPIError(e);
      debugPrint(e.message);
      gett.Get.find<LoginController>().loginError =
          Map<dynamic, dynamic>.from(e.response?.data).entries.first.value[0];
      gett.Get.find<LoginController>().update();
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<LoginUserResponse> verifyMobileLoginOTP({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response = await dioClient
          .post(Endpoints.mobileLoginOTPVerify, data: FormData.fromMap(body));
      final LoginUserResponse responseModel =
          LoginUserResponse.fromJson(response.data);
      return responseModel;
    } on DioException catch (e) {
      Loader.load(false);
      Utility.showAPIError(e);
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<CommonDetailModel> forgotPassword({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.forgotPassword, data: body);
      final CommonDetailModel responseModel =
          CommonDetailModel.fromJson(response.data);
      return responseModel;
    } on DioException catch (e) {
      Loader.load(false);
      Utility.showAPIError(e);
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<CommonDetailModel> resetPassword({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.resetPassword, data: body);
      final CommonDetailModel responseModel =
          CommonDetailModel.fromJson(response.data);
      return responseModel;
    } on DioException catch (e) {
      Loader.load(false);
      Utility.showAPIError(e);
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> createUser({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.signup, data: body);
      return response.statusCode == 201;
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
      final Response<dynamic> response = await dioClient.post(
          Endpoints.verifyOTP,
          data: FormData.fromMap(body),
          queryParameters: queryParams);
      final LoginUserResponse loginResponse =
          LoginUserResponse.fromJson(response.data);

      Utility.saveUserDetails(loginResponse);

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
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.resendOTP, data: body);
      return response.statusCode == 200;
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> logOutApi() async {
    try {
      // this req keeping here because it's mandatory so no one can update from any file.
      final Map<String, dynamic> req = <String, dynamic>{
        'registration_id': sharedPreferences.fcmToken ?? ''
      };
      await dioClient.post(Endpoints.logOut, data: req);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
