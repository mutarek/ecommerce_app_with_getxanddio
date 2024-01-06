import 'package:api_calling_get/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';

class MyHomePage extends GetView<HomeController> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    final bodyWidth = MediaQuery.of(context).size.width;
    final bodyHeight = MediaQuery.of(context).size.height;
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: const Text("Get Api Call"),
          ),
          body: controller.productList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.73,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemCount: controller.productList.length,
                    itemBuilder: (_, index) {
                      var data = controller.productList[index];
                      return SizedBox(
                        width: bodyWidth * 0.40,
                        height: bodyHeight * 0.34,
                        child: LayoutBuilder(
                          builder: (_, constraints) {
                            return InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  bodyWidth * 0.03)),
                                          child: Hero(
                                            tag: data.id ?? "",
                                            child: Image.network(
                                              data.thumbnail ?? "",
                                              width:
                                                  constraints.maxWidth * 1.00,
                                              height:
                                                  constraints.maxHeight * 0.71,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: constraints.maxWidth / 1.32,
                                          top: constraints.maxHeight / 1.59,
                                          child: FavoriteButton(
                                            parentWidth: constraints.maxWidth,
                                            parentHeight: constraints.maxHeight,
                                            product: data,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        3,
                                        (index) => const Icon(
                                          Icons.star_border_rounded,
                                          color: Color(0xFF9B9B9B),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.02,
                                  ),
                                  Text(
                                    data.brand ?? "Brand Name",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.02,
                                  ),
                                  Text(
                                    data.title ?? "",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.01,
                                  ),
                                  Text(
                                    '${data.price ?? 0 * 100}\৳',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required this.parentWidth,
    required this.parentHeight,
    required this.product,
  }) : super(key: key);
  final double parentWidth;
  final double parentHeight;
  final Product product;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(
      color: const Color(0xFF9B9B9B),
      blurRadius: widget.parentWidth * 0.001,
      spreadRadius: widget.parentWidth * 0.001,
      offset: Offset(0, widget.parentWidth * 0.005),
    );

    return Container(
      width: widget.parentWidth * 0.24,
      height: widget.parentHeight * 0.14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          boxShadow,
        ],
      ),
      child: IconButton(
        color: (isFavorite) ? const Color(0xFFDB3022) : const Color(0xFF9B9B9B),
        icon: (isFavorite)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }
}
