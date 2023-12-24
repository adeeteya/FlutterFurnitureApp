import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/models/address.dart';
import 'package:timberr/screens/input/edit_shipping_screen.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final int index;
  final bool isEditable;
  const AddressCard(
      {super.key,
      this.isEditable = true,
      required this.address,
      required this.index});

  void _onEditTap() {
    Get.to(
      () => EditShippingScreen(
        initialAddress: address,
        index: index,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address.name,
                  style: kNunitoSansBold18,
                ),
                if (isEditable)
                  GestureDetector(
                    onTap: _onEditTap,
                    child: SvgPicture.asset(
                      "assets/icons/edit_icon.svg",
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: kSnowFlakeWhite,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Text(
              address.displayAddress(),
              style: kNunitoSans14.copyWith(
                color: kGrey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
