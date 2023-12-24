import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/address_controller.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/controllers/payment_controller.dart';
import 'package:timberr/screens/profile/payment_methods_screen.dart';
import 'package:timberr/screens/profile/shipping_address_screen.dart';
import 'package:timberr/widgets/buttons/custom_elevated_button.dart';
import 'package:timberr/widgets/cards/address_card.dart';

class CheckOutScreen extends StatelessWidget {
  final int orderAmount;
  CheckOutScreen({super.key, required this.orderAmount});
  final AddressController _addressController = Get.find();
  final CardDetailsController _cardDetailController = Get.find();
  final _paymentController = Get.put(PaymentController());
  void _toShippingAddressScreen() {
    Get.to(
      () => const ShippingAddressScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void _toPaymentMethodsScreen() {
    Get.to(
      () => PaymentMethodsScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void _openCheckout() {
    if (_addressController.addressList.isEmpty) {
      kDefaultDialog("No Address Added", "Please add an address to proceed");
      return;
    }
    if (_cardDetailController.cardDetailList.isEmpty) {
      kDefaultDialog("No Card Added", "Please add a Card to proceed");
      return;
    }
    _paymentController.openCheckout(orderAmount);
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
          "CHECK-OUT",
          style: kMerriweatherBold16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Address",
                  style: kNunitoSansSemiBold18.copyWith(
                    color: kTinGrey,
                  ),
                ),
                IconButton(
                  onPressed: _toShippingAddressScreen,
                  icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                ),
              ],
            ),
            GetBuilder<AddressController>(
              builder: (addressController) {
                if (addressController.addressList.isNotEmpty) {
                  return AddressCard(
                    isEditable: false,
                    address: addressController
                        .addressList[addressController.selectedIndex],
                    index: addressController.selectedIndex,
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Shipping Addresses have been entered",
                      style: kNunitoSans14.copyWith(
                        color: kGrey,
                      ),
                    ),
                  );
                }
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment",
                  style: kNunitoSansSemiBold18.copyWith(
                    color: kTinGrey,
                  ),
                ),
                IconButton(
                  onPressed: _toPaymentMethodsScreen,
                  icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                ),
              ],
            ),
            Obx(() {
              return Container(
                height: 69,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x408A959E),
                      offset: Offset(0, 8),
                      blurRadius: 40,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 38,
                      width: 64,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x20000000),
                            offset: Offset(0, 1),
                            blurRadius: 25,
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/mastercard_bw.svg',
                        height: 25,
                        width: 32,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Text(
                      "**** **** **** ${_cardDetailController.getLastFourDigits()}",
                      style: kNunitoSans14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: kRaisinBlack,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery method",
                  style: kNunitoSansSemiBold18.copyWith(
                    color: kTinGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                ),
              ],
            ),
            Container(
              height: 54,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x408A959E),
                    offset: Offset(0, 8),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Image.asset("assets/dhl.png"),
                  const SizedBox(width: 15),
                  Text(
                    "Fast (2-3 days)",
                    style: kNunitoSans14.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Container(
              height: 135,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x408A959E),
                    offset: Offset(0, 8),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order:",
                        style: kNunitoSansTinGrey18,
                      ),
                      Text(
                        "\$ $orderAmount.00",
                        style: kNunitoSansSemiBold18,
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery:",
                        style: kNunitoSansTinGrey18,
                      ),
                      Text(
                        "\$ 5.00",
                        style: kNunitoSansSemiBold18,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: kNunitoSansTinGrey18,
                      ),
                      Text(
                        "\$ ${orderAmount + 5}.00",
                        style: kNunitoSansSemiBold18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onTap: _openCheckout,
              text: 'Submit Order',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
