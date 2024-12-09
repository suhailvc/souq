import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/notifications/notification_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NotificationRepo {
  NotificationRepo({required this.dioClient});

  DioClient dioClient;

  Future<NotificationResponseModel> getNotificationList(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response = await dioClient
          .get(Endpoints.notifications, queryParameters: queryParams);
      return NotificationResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
