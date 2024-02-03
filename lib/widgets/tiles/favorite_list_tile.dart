import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/controllers/favorites_controller.dart';
import 'package:timberr/models/product.dart';
import 'package:timberr/screens/product/product_screen.dart';

class FavoriteListTile extends StatelessWidget {
  final Product product;
  final FavoritesController _favoritesController = Get.find();
  final CartController _cartController = Get.find();
  FavoriteListTile({super.key, required this.product});

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

  void _removeProduct() {
    _favoritesController.removeProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: _productOnTap,
            child: Hero(
              tag: product.imagesList[0],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  cacheKey: product.imagesList[0],
                  imageUrl: product.imagesList[0],
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/furniture_loading.gif',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    );
                  },
                  height: 100,
                  width: 100,
                  maxHeightDiskCache: (size.height * 2).toInt(),
                  maxWidthDiskCache: (size.width * 2).toInt(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: kNunitoSans14.copyWith(
                      color: kGraniteGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$ ${product.price}",
                    style: kNunitoSansBold16,
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _removeProduct,
                customBorder: const CircleBorder(),
                child: const Icon(
                  Icons.highlight_off,
                  size: 20,
                  color: kNoghreiSilver,
                ),
              ),
              InkWell(
                onTap: _addToCart,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Ink(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kChristmasSilver,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/shopping_bag_icon_black.svg",
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
