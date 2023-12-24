import 'package:flutter/material.dart';
import 'package:timberr/constants.dart';

class CustomDropdownBox extends StatefulWidget {
  final String headerText;
  final String hintText;
  final List<DropdownMenuItem> items;
  final Function(String val) onChanged;
  final String? Function(dynamic val)? validator;
  final String? initialValue;
  const CustomDropdownBox(
      {super.key,
      required this.headerText,
      required this.hintText,
      required this.items,
      required this.onChanged,
      this.validator,
      this.initialValue});

  @override
  State<CustomDropdownBox> createState() => _CustomDropdownBoxState();
}

class _CustomDropdownBoxState extends State<CustomDropdownBox> {
  late bool isFilled;

  @override
  void initState() {
    super.initState();
    isFilled = (widget.initialValue == null) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: (isFilled) ? Colors.white : kLynxWhite,
        border: (isFilled)
            ? Border.all(
                color: kChristmasSilver,
              )
            : const Border(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.headerText,
            style: kNunitoSans12TrolleyGrey,
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField(
            isDense: true,
            alignment: AlignmentDirectional.bottomEnd,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isCollapsed: true,
              hintText: widget.hintText,
              hintStyle: kNunitoSansSemiBold16NorgheiSilver,
              border: InputBorder.none,
            ),
            items: widget.items,
            value: widget.initialValue,
            onChanged: (dynamic val) {
              setState(() {
                isFilled = true;
              });
              widget.onChanged(val);
            },
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
