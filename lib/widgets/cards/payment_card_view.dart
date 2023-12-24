import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timberr/constants.dart';

class PaymentCardView extends StatelessWidget {
  final bool? isMasterCard;
  final bool isSelected;
  final String lastFourDigits;
  final String cardHolderName;
  final String expiryDateString;
  const PaymentCardView(
      {super.key,
      required this.lastFourDigits,
      required this.cardHolderName,
      required this.expiryDateString,
      this.isSelected = true,
      this.isMasterCard});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 180,
      width: double.infinity,
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: (isSelected) ? kRaisinBlack : kBasaltGrey,
        image: const DecorationImage(
          image: AssetImage("assets/card_bg.png"),
          alignment: Alignment(1.3, 1.3),
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            offset: Offset(0, 1),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0, 0.97),
            blurRadius: 24.27,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isMasterCard == null)
              ? Row(
                  children: [
                    SvgPicture.asset("assets/icons/mastercard.svg"),
                    const SizedBox(width: 20),
                    SvgPicture.asset("assets/icons/visacard.svg")
                  ],
                )
              : SvgPicture.asset(
                  (isMasterCard!)
                      ? "assets/icons/mastercard.svg"
                      : "assets/icons/visacard.svg",
                ),
          RichText(
            text: TextSpan(
              text: "* * * *  * * * *  * * * *  ",
              style: kNunitoSansBold20.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: lastFourDigits,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Card Holder Name",
                    style: kNunitoSansSemiBold12,
                  ),
                  Text(
                    cardHolderName,
                    style: kNunitoSans14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Expiry Date",
                    style: kNunitoSansSemiBold12,
                  ),
                  Text(
                    expiryDateString,
                    style: kNunitoSans14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
