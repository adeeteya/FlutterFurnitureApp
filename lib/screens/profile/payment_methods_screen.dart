import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/screens/input/add_payment_screen.dart';
import 'package:timberr/widgets/cards/payment_card_view.dart';

class PaymentMethodsScreen extends StatelessWidget {
  PaymentMethodsScreen({super.key});
  final CardDetailsController _cardDetailsController = Get.find();
  void _toAddPaymentScreen() {
    Get.to(
      () => AddPaymentScreen(),
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
          "PAYMENT METHOD",
          style: kMerriweatherBold16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toAddPaymentScreen,
        elevation: 8,
        backgroundColor: Colors.white,
        foregroundColor: kOffBlack,
        child: const Icon(
          Icons.add,
          size: 34,
        ),
      ),
      body: Obx(() {
        if (_cardDetailsController.cardDetailList.isEmpty) {
          return Center(
            child: Text(
              "No Payment Details have been added",
              style: kNunitoSans14.copyWith(
                color: kGrey,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: _cardDetailsController.cardDetailList.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          itemBuilder: (context, index) {
            return Obx(() {
              return Column(
                children: [
                  PaymentCardView(
                    cardHolderName: _cardDetailsController.cardDetailList
                        .elementAt(index)
                        .name,
                    lastFourDigits: _cardDetailsController.cardDetailList
                        .elementAt(index)
                        .cardNumber
                        .toString()
                        .substring(12),
                    expiryDateString:
                        "${_cardDetailsController.cardDetailList.elementAt(index).month}/${_cardDetailsController.cardDetailList.elementAt(index).year}",
                    isMasterCard: index % 2 == 0,
                    isSelected:
                        _cardDetailsController.selectedIndex.value == index,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Checkbox(
                          value: (_cardDetailsController.selectedIndex.value ==
                                  index)
                              ? true
                              : false,
                          onChanged: (isSelected) {
                            _cardDetailsController.setDefaultCardDetail(index);
                          },
                          activeColor: kOffBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          splashRadius: 20,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      Text(
                        "Use as default payment method",
                        style: kNunitoSans14.copyWith(
                          color: kRaisinBlack,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              );
            });
          },
        );
      }),
    );
  }
}
