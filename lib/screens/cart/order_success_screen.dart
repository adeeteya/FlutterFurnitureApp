import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/screens/profile/orders_screen.dart';
import 'package:timberr/widgets/buttons/custom_elevated_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  void _offToHome() {
    Get.back();
    Get.back();
  }

  void _offToOrderScreen() {
    Get.back();
    Get.back();
    Get.to(
      () => const OrdersScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => kOnExitConfirmation(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Text(
                  "SUCCESS!",
                  style: kMerriweatherBold16.copyWith(
                    fontSize: 36,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset("assets/order_success.svg", height: 230),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: kCrayolaGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  "Your order will be delivered soon.\nThank you for choosing our app!",
                  style: kNunitoSans18.copyWith(
                    color: kGraniteGrey,
                  ),
                ),
                const Spacer(),
                CustomElevatedButton(
                  onTap: _offToOrderScreen,
                  text: "TRACK YOUR ORDERS",
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _offToHome,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kOffBlack,
                      side: const BorderSide(color: kOffBlack),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "BACK TO HOME",
                      style: kNunitoSansSemiBold18,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
