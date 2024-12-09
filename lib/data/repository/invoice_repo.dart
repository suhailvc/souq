import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/response_models/invoice/invoice_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InvoiceRepo {
  InvoiceRepo({required this.dioClient});

  DioClient dioClient;

  Future<InvoiceListModel> getInvoiceList(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      final Response<dynamic> response =
          await dioClient.get(Endpoints.invoices, queryParameters: queryParams);
      return InvoiceListModel.fromJson(response.data);
    } on DioException catch (e) {
      Utility.showAPIError(e);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
