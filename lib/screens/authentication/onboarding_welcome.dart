import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/screens/authentication/login_screen.dart';

class OnBoardingWelcomeScreen extends StatelessWidget {
  const OnBoardingWelcomeScreen({super.key});

  void _toLoginScreen() {
    Get.to(
      () => const LoginScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onBoarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MAKE YOUR',
                  style: kGelasio18.copyWith(
                    color: kGraniteGrey,
                    fontSize: 24,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'HOME BEAUTIFUL',
                  style: kGelasio18.copyWith(
                    color: kOffBlack,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 25),
                  child: Text(
                    "The best simple place where you discover most wonderful furniture's and make your home beautiful",
                    style: kNunitoSans18.copyWith(
                      color: kGrey,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
            Container(
              height: 55,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: _toLoginScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kLeadBlack,
                  shadowColor: kOffBlack,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: kGelasio18.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
