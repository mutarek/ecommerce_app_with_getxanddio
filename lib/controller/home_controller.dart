import 'package:api_calling_get/model/product_model.dart';
import 'package:api_calling_get/repo/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;

  final HomeRepository homeRepository = HomeRepository();

  var productList = <Product>[].obs;

  getDummyData() async {
    ProductModel response = await homeRepository.getCustomerSupplierList();
    productList.value = response.products ?? [];
  }

  @override
  void onInit() {
    getDummyData();
    super.onInit();
  }
}
