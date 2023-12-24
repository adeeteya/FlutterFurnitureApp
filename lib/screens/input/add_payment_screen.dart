import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/add_payment_controller.dart';
import 'package:timberr/widgets/buttons/custom_elevated_button.dart';
import 'package:timberr/widgets/cards/payment_card_view.dart';
import 'package:timberr/widgets/input/custom_input_box.dart';

class AddPaymentScreen extends StatelessWidget {
  AddPaymentScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(AddPaymentController());
  void _addCard() {
    if (_formKey.currentState?.validate() ?? false) {
      _controller.addCardDetail();
    }
  }

  void _nameOnChanged(String val) {
    _controller.name.value = val;
  }

  void _cardNumberOnChanged(String val) {
    _controller.cardNumber = int.parse(val.replaceAll(" ", ""));
    if (val.length >= 16) {
      _controller.lastFourDigits.value = val.substring(15);
    } else {
      _controller.lastFourDigits.value = "";
    }
  }

  void _cvvOnChanged(String val) {
    _controller.cvv = int.parse(val);
  }

  void _dateOnChanged(String val) {
    _controller.dateString.value = val;
    if (val.length == 5) {
      _controller.month = int.parse(val[0] + val[1]);
      _controller.year = int.parse(val[3] + val[4]);
    }
  }

  String? _nameValidator(String? val) {
    return (val?.isNotEmpty ?? false) ? null : "Enter a name";
  }

  String? _cardNumberValidator(String? val) {
    return (val != null && val.length == 20)
        ? null
        : "Enter a Valid Credit Card Number";
  }

  String? _cvvValidator(String? val) {
    return (val != null && val.length == 3) ? null : "Enter CVV";
  }

  String? _dateValidator(String? val) {
    return (_controller.month > 0 &&
            _controller.month < 13 &&
            _controller.year > 21)
        ? null
        : "Enter a Valid Date";
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
          "ADD PAYMENT METHOD",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(
                  () {
                    return PaymentCardView(
                      cardHolderName: (_controller.name.isEmpty)
                          ? "XXXXXX"
                          : _controller.name.value,
                      expiryDateString: (_controller.dateString.isEmpty)
                          ? "XX/XX"
                          : _controller.dateString.value,
                      lastFourDigits: (_controller.lastFourDigits.isEmpty)
                          ? "XXXX"
                          : _controller.lastFourDigits.value,
                    );
                  },
                ),
                const SizedBox(height: 30),
                CustomInputBox(
                  headerText: "CardholderName",
                  hintText: "Ex: Aditya R",
                  textInputType: TextInputType.name,
                  onChanged: _nameOnChanged,
                  validator: _nameValidator,
                ),
                CustomInputBox(
                  headerText: "Card Number",
                  hintText: "Ex: XXXX XXXX XXXX 3456",
                  textInputType: TextInputType.number,
                  maxLength: 20,
                  inputFormatters: [CreditCardFormatter()],
                  onChanged: _cardNumberOnChanged,
                  validator: _cardNumberValidator,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomInputBox(
                        headerText: "CVV",
                        hintText: "Ex: 123",
                        maxLength: 3,
                        obscureText: true,
                        onChanged: _cvvOnChanged,
                        validator: _cvvValidator,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomInputBox(
                        headerText: "Expiration Date",
                        hintText: "Ex: 04/22",
                        maxLength: 5,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [DateFormatter()],
                        onChanged: _dateOnChanged,
                        validator: _dateValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  onTap: _addCard,
                  text: "ADD NEW CARD",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
