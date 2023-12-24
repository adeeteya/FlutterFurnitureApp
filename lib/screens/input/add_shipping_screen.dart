import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/address_controller.dart';
import 'package:timberr/widgets/buttons/custom_elevated_button.dart';
import 'package:timberr/widgets/input/custom_dropdown_box.dart';
import 'package:timberr/widgets/input/custom_input_box.dart';

class AddShippingScreen extends StatelessWidget {
  AddShippingScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final AddressController _addressController = Get.find();

  void _nameOnChanged(String val) {
    _addressController.name = val;
  }

  String? _nameValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter your name";
    } else {
      return null;
    }
  }

  void _addressOnChanged(String val) {
    _addressController.address = val;
  }

  String? _addressValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter the address";
    } else {
      return null;
    }
  }

  void _pincodeOnChanged(String val) {
    _addressController.pincode = int.parse(val);
  }

  String? _pincodeValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter your pincode";
    } else if (!val!.isNum) {
      return "Please enter a valid pincode";
    } else if (val.length != 6) {
      return "Pincode must be 6 characters long";
    } else {
      return null;
    }
  }

  void _countryOnChanged(String val) {
    _addressController.country = val;
  }

  String? _countryValidator(val) {
    return (val == null) ? "Please Select the Country" : null;
  }

  void _cityOnChanged(String val) {
    _addressController.city = val;
  }

  String? _cityValidator(val) {
    return (val == null) ? "Please Select the City" : null;
  }

  void _districtOnChanged(String val) {
    _addressController.district = val;
  }

  String? _districtValidator(val) {
    return (val == null) ? "Please Select the District" : null;
  }

  void _uploadAddress() {
    if (_formKey.currentState!.validate()) {
      _addressController.uploadAddress();
    }
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
          "ADD SHIPPING ADDRESS",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInputBox(
                  headerText: "Full name",
                  hintText: "Ex: Aditya R",
                  textInputType: TextInputType.name,
                  onChanged: _nameOnChanged,
                  validator: _nameValidator,
                ),
                CustomInputBox(
                  headerText: "Address",
                  hintText: "Ex: 87 Church Street",
                  textInputType: TextInputType.streetAddress,
                  onChanged: _addressOnChanged,
                  validator: _addressValidator,
                ),
                CustomInputBox(
                  headerText: "Zipcode (Postal Code)",
                  hintText: "Ex: 600014",
                  maxLength: 6,
                  textInputAction: TextInputAction.done,
                  onChanged: _pincodeOnChanged,
                  validator: _pincodeValidator,
                ),
                CustomDropdownBox(
                  headerText: "Country",
                  hintText: "Select Country",
                  items: const [
                    DropdownMenuItem(
                      value: "India",
                      child: Text("India"),
                    )
                  ],
                  onChanged: _countryOnChanged,
                  validator: _countryValidator,
                ),
                CustomDropdownBox(
                  headerText: "City",
                  hintText: "Select City",
                  items: const [
                    DropdownMenuItem(
                      value: "Chennai",
                      child: Text("Chennai"),
                    )
                  ],
                  onChanged: _cityOnChanged,
                  validator: _cityValidator,
                ),
                CustomDropdownBox(
                  headerText: "District",
                  hintText: "Select District",
                  items: const [
                    DropdownMenuItem(
                      value: "Mylapore",
                      child: Text("Mylapore"),
                    )
                  ],
                  onChanged: _districtOnChanged,
                  validator: _districtValidator,
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  onTap: _uploadAddress,
                  text: "SAVE ADDRESS",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
