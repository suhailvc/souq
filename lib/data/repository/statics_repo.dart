import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/static_pages/contact_us_reponse_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/static_pages/static_page_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StaticsRepository {
  StaticsRepository({required this.dioClient});
  DioClient dioClient;

  Future<StaticPageDetails> getStaticPageDetailsApiRequest(
      final String slugName) async {
    try {
      final Response<dynamic> response =
          await dioClient.get('${Endpoints.staticPages}$slugName');
      final StaticPageDetails responseModel =
          StaticPageDetails.fromJson(response.data);
      return responseModel;
    } on DioException catch (e) {
      Loader.load(false);
      Utility.showAPIError(e);
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<ContactUsResponse> callContactUsApiRequest({
    required final Map<String, dynamic> body,
  }) async {
    try {
      final Response<dynamic> response =
          await dioClient.post(Endpoints.contactUS, data: body);
      return ContactUsResponse.fromJson(response.data);
    } on DioException catch (e) {
      Loader.load(false);
      Utility.showAPIError(e);
      debugPrint(e.message);
      rethrow;
    }
  }
}
