import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timberr/constants.dart';

class CustomInputBox extends StatefulWidget {
  final String headerText;
  final String hintText;
  final Function(String val) onChanged;
  final String? Function(String? val)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String? initialValue;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  const CustomInputBox({
    super.key,
    required this.headerText,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.number,
    required this.onChanged,
    this.initialValue,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.obscureText = false,
  });

  @override
  State<CustomInputBox> createState() => _CustomInputBoxState();
}

class _CustomInputBoxState extends State<CustomInputBox> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  bool isFilled = false;
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFilled = true;
        });
      } else if (_textEditingController.text == "") {
        setState(() {
          isFilled = false;
        });
      }
    });
    if (_textEditingController.text != "") {
      isFilled = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
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
          TextFormField(
            controller: _textEditingController,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            validator: widget.validator,
            onFieldSubmitted: (val) {
              if (val == '') {
                setState(() {
                  isFilled = false;
                });
              }
            },
            obscureText: widget.obscureText,
            maxLength: widget.maxLength,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            cursorColor: kOffBlack,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isCollapsed: true,
              hintText: widget.hintText,
              hintStyle: kNunitoSansSemiBold16NorgheiSilver,
              counterText: "",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String actualText = newValue.text.replaceAll(" ", "");
    String newText = "";
    for (int i = 0; i < actualText.length; i++) {
      if (i % 4 == 0) {
        newText += ' ';
      }
      newText += actualText[i];
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String actualText = newValue.text.replaceAll("/", "");
    String newText = "";
    for (int i = 0; i < actualText.length; i++) {
      if (i == 2) {
        newText += '/';
      }
      newText += actualText[i];
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
