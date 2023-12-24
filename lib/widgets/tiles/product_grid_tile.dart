import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/screens/product/product_screen.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  final bool heroMode;
  final CartController _cartController = Get.find();
  ProductGridTile({super.key, required this.product, this.heroMode = true});

  void _productOnTap() {
    Get.to(
      () => ProductScreen(product: product),
      duration: const Duration(milliseconds: 500),
      transition: Transition.fadeIn,
    );
  }

  void _addToCart() {
    _cartController.addToCart(product, product.colorsList[0]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _productOnTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.7,
            child: HeroMode(
              enabled: heroMode,
              child: Hero(
                tag: product.imagesList[0],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        cacheKey: product.imagesList[0],
                        imageUrl: product.imagesList[0],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          if (downloadProgress.progress == null) {
                            return const SizedBox();
                          } else {
                            return Image.asset(
                              'assets/furniture_loading.gif',
                              height: 500,
                              width: 500,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                        height: 500,
                        width: 500,
                        maxHeightDiskCache: (size.height * 2).toInt(),
                        maxWidthDiskCache: (size.width * 2).toInt(),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 12,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: _addToCart,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: kGraniteGrey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/shopping_bag_icon.svg',
                              height: 20,
                              width: 20,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            style: kNunitoSans14.copyWith(
              color: kGraniteGrey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '\$ ${product.price}.00',
            style: kNunitoSans14.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
