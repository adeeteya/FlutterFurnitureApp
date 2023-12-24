import 'package:flutter/material.dart';
import 'package:timberr/constants.dart';

class SettingRowTile extends StatelessWidget {
  final String fieldName;
  final Widget action;
  const SettingRowTile(
      {super.key, required this.fieldName, required this.action});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fieldName,
            style: kNunitoSansSemiBold16.copyWith(
              color: kRaisinBlack,
            ),
          ),
          action,
        ],
      ),
    );
  }
}
