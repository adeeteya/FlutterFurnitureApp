import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:timberr/controllers/address_controller.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/controllers/favorites_controller.dart';
import 'package:timberr/controllers/home_controller.dart';
import 'package:timberr/controllers/user_controller.dart';
import 'package:timberr/screens/home.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final HomeController _homeController = Get.find();
  final FavoritesController _favoritesController = Get.find();
  final CartController _cartController = Get.find();
  final UserController _userController = Get.find();
  final CardDetailsController _cardDetailsController = Get.find();
  final AddressController _addressController = Get.find();
  Future initControllers() async {
    await _homeController.getProducts(0);
    await _favoritesController.fetchFavorites();
    await _cartController.fetchCartItems();
    await _userController.fetchUserData();
    await _cardDetailsController.getDefaultCardDetail();
    await _addressController.getDefaultShippingAddress();
    Get.off(() => Home());
  }

  @override
  StatelessElement createElement() {
    initControllers();
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            LottieBuilder.asset("assets/lottie/splash_loading_animation.json"),
      ),
    );
  }
}
