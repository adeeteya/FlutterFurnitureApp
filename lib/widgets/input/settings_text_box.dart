import 'package:flutter/material.dart';
import 'package:timberr/constants.dart';

class SettingsTextBox extends StatelessWidget {
  final String fieldName;
  final String value;

  const SettingsTextBox(
      {super.key, required this.fieldName, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x408A959E),
            offset: Offset(0, 2),
            blurRadius: 40,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: kNunitoSans12TrolleyGrey,
          ),
          Text(
            value,
            style: kNunitoSans14.copyWith(
              fontWeight: FontWeight.w600,
              color: kRaisinBlack,
            ),
          ),
        ],
      ),
    );
  }
}
