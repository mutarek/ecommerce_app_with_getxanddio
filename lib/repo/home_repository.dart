import 'package:api_calling_get/global/app_constant.dart';
import 'package:api_calling_get/model/product_model.dart';
import 'package:api_calling_get/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../network/dio_exceptions.dart';

class HomeRepository {
  Future<ProductModel> getProductsList() async {
    try {
      Response response = await DioClient()
          .dio
          .get(AppConstant.baseUrl + AppConstant.productsUrl);
      return ProductModel.fromJson(response.data);
    } catch (e) {
      var errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = DioExceptions.fromDioError(e).toString();
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      return ProductModel();
    }
  }

  Future<SingleProduct> getSingleProducts(String id) async {
    try {
      Response response = await DioClient()
          .dio
          .get("${AppConstant.baseUrl}${AppConstant.productsUrl}/$id");
      return SingleProduct.fromJson(response.data);
    } catch (e) {
      var errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = DioExceptions.fromDioError(e).toString();
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      return SingleProduct();
    }
  }
}
