import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/controllers/user_controller.dart';
import 'package:timberr/screens/cart/order_success_screen.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  final CartController _cartController = Get.find();
  final UserController _userController = Get.find();
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(int orderAmount) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var options = {
      'key': 'rzp_test_F1usoYnQRtiMLu',
      'amount': (orderAmount + 5) * 100,
      'currency': 'USD',
      'name': 'Timberr',
      'description': 'Working Furniture Clone app by Aditya using Flutter.',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'name': _userController.userData.name,
        'email': _userController.userData.email
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      kDefaultDialog("Payment Failed",
          "Unable to contact the razorpay servers. Please try again after sometime");
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await _cartController.removeAllFromCart();
    Get.off(
      () => const OrderSuccessScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    kDefaultDialog("Payment Failed",
        "There was an error processing your payment. Please try again after sometime");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}
}
