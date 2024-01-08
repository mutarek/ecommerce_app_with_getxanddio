import 'package:api_calling_get/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends GetView<HomeController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text("Single Product Detail"),
        ),
        body: controller.isSingleLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                children: [Text(controller.productDetails.value.title ?? '')],
              ))));
  }
}
