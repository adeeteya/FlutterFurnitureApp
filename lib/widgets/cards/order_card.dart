import 'package:flutter/material.dart';
import 'package:timberr/constants.dart';

class OrderCard extends StatelessWidget {
  final int orderNumber;
  final int quantity;
  final int totalAmount;
  final int orderStatus;
  final String dateString;
  const OrderCard(
      {super.key,
      required this.orderNumber,
      required this.quantity,
      required this.totalAmount,
      required this.dateString,
      this.orderStatus = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      margin: const EdgeInsets.symmetric(vertical: 10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order no $orderNumber",
                  style: kNunitoSansSemiBold16,
                ),
                Text(
                  dateString,
                  style: kNunitoSans14.copyWith(
                    color: kTinGrey,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: kSnowFlakeWhite,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
            child: Row(
              children: [
                const Text(
                  "Quantity: ",
                  style: kNunitoSansSemiBold16TinGrey,
                ),
                Text(
                  "${quantity < 10 ? '0' : ''}$quantity",
                  style: kNunitoSansSemiBold16,
                ),
                const Spacer(),
                const Text(
                  "Total amount: ",
                  style: kNunitoSansSemiBold16TinGrey,
                ),
                Text(
                  "\$$totalAmount",
                  style: kNunitoSansSemiBold16,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 36,
                decoration: const BoxDecoration(
                  color: kOffBlack,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Detail",
                    style: kNunitoSansSemiBold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                (orderStatus == 0)
                    ? "Delivered"
                    : (orderStatus == 1)
                        ? "Processing"
                        : "Cancelled",
                style: kNunitoSansSemiBold16.copyWith(
                  color: (orderStatus == 0)
                      ? kCrayolaGreen
                      : (orderStatus == 1)
                          ? kOffBlack
                          : kFireOpal,
                ),
              ),
              const SizedBox(width: 15),
            ],
          )
        ],
      ),
    );
  }
}
