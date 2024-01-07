import 'package:api_calling_get/model/product_model.dart';
import 'package:api_calling_get/repo/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var isSingleLoading = true.obs;

  final HomeRepository homeRepository = HomeRepository();

  var productList = <Product>[].obs;
  var productDetails = SingleProduct().obs;

  getDummyData() async {
    ProductModel response = await homeRepository.getProductsList();
    productList.value = response.products ?? [];
  }

  getProductDetails(String id) async {
    isSingleLoading.value = true;
    SingleProduct response = await homeRepository.getSingleProducts(id);
    var product = SingleProduct();
    product.thumbnail = response.thumbnail;
    product.id = response.id;
    product.category = response.category;
    product.stock = response.stock;
    product.title = response.title;
    product.price = response.price;
    product.brand = response.brand;
    product.description = response.description;
    product.discountPercentage = response.discountPercentage;
    productDetails.value = product as SingleProduct;
    isSingleLoading.value = false;
  }

  @override
  void onInit() {
    getDummyData();
    super.onInit();
  }
}
