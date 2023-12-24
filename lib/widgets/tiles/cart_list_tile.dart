import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/models/cart_item.dart';
import 'package:timberr/screens/product/product_screen.dart';

class CartListTile extends StatelessWidget {
  final CartItem cartItem;
  final CartController _controller = Get.find();
  CartListTile({super.key, required this.cartItem});

  void _productOnTap() {
    Get.to(
      () => ProductScreen(product: cartItem.getProduct()),
      duration: const Duration(milliseconds: 500),
      transition: Transition.fadeIn,
    );
  }

  void _removeFromCart() async {
    await _controller.removeFromCart(cartItem);
  }

  void _incrementQuantity() {
    _controller.incrementQuantity(cartItem);
  }

  void _decrementQuantity() {
    _controller.decrementQuantity(cartItem);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _productOnTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: cartItem.color, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Hero(
                tag: cartItem.imagesList[0],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    cacheKey: cartItem.imagesList[0],
                    imageUrl: cartItem.imagesList[0],
                    placeholder: (context, url) {
                      return Image.asset(
                        'assets/furniture_loading.gif',
                        height: 500,
                        width: 500,
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
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.name,
                      style: kNunitoSans14.copyWith(
                        color: kGraniteGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: _removeFromCart,
                      customBorder: const CircleBorder(),
                      child: const Icon(
                        Icons.highlight_off,
                        size: 20,
                        color: kNoghreiSilver,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _incrementQuantity,
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: kChristmasSilver,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: kTinGrey,
                        ),
                      ),
                    ),
                    GetBuilder<CartController>(builder: (controller) {
                      return Text(
                        "${cartItem.quantity}",
                        style: kNunitoSansSemiBold18,
                      );
                    }),
                    GestureDetector(
                      onTap: _decrementQuantity,
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: kChristmasSilver,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: kTinGrey,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$ ${cartItem.price}',
                      style: kNunitoSansBold16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
