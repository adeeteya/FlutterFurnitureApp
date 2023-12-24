import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/screens/cart/check_out_screen.dart';
import 'package:timberr/widgets/buttons/custom_elevated_button.dart';
import 'package:timberr/widgets/tiles/cart_list_tile.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController _controller = Get.find();

  void _toCheckOutScreen() {
    Get.to(
      () => CheckOutScreen(
        orderAmount: _controller.total.value,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kOffBlack,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "MY CART",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(() {
          if (_controller.cartList.isEmpty) {
            return const Center(child: Text("No Item present in the cart"));
          }
          return Column(children: [
            Expanded(
              child: ListView.separated(
                itemCount: _controller.cartList.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CartListTile(
                    cartItem: _controller.cartList.elementAt(index),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 12,
                    thickness: 1,
                    color: kSnowFlakeWhite,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x258A959E),
                          offset: Offset(0, 2),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: TextField(
                      style: kNunitoSansSemiBold16,
                      maxLength: 6,
                      cursorColor: kOffBlack,
                      decoration: InputDecoration(
                        counter: const Offstage(),
                        contentPadding:
                            const EdgeInsets.only(left: 20, top: 25),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x128A959E),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x128A959E),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: kOffBlack,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        hintText: "Enter your Promo Code",
                        hintStyle: kNunitoSans16.copyWith(
                          fontWeight: FontWeight.normal,
                          height: 1,
                          color: kBasaltGrey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ",
                          style: kNunitoSansBold20.copyWith(
                            color: kGrey,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            "\$ ${_controller.total.value}.00",
                            style: kNunitoSansBold20,
                          );
                        })
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    onTap: _toCheckOutScreen,
                    text: 'CHECK OUT',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ]);
        }),
      ),
    );
  }
}
