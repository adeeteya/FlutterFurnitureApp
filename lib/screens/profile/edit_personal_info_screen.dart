import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/user_controller.dart';
import 'package:timberr/widgets/buttons/custom_elevated_button.dart';
import 'package:timberr/widgets/input/custom_input_box.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  const EditPersonalInformationScreen({super.key});

  @override
  State<EditPersonalInformationScreen> createState() =>
      _EditPersonalInformationScreenState();
}

class _EditPersonalInformationScreenState
    extends State<EditPersonalInformationScreen> {
  String name = "";
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = Get.find();
  void _nameOnChanged(String val) {
    name = val;
  }

  String? _nameValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter the name";
    } else {
      return null;
    }
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate()) {
      _userController.setName(name);
    }
  }

  @override
  void initState() {
    name = _userController.userData.name;
    super.initState();
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
          "EDIT PERSONAL INFORMATION",
          style: kMerriweatherBold16,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomInputBox(
                headerText: "Name",
                hintText: "Ex: Aditya",
                initialValue: name,
                textInputType: TextInputType.name,
                onChanged: _nameOnChanged,
                validator: _nameValidator,
              ),
              AbsorbPointer(
                child: CustomInputBox(
                  headerText: "Email",
                  hintText: "Ex: adeeteya@gmail.com",
                  initialValue: _userController.userData.email,
                  onChanged: (val) {},
                ),
              ),
              const Spacer(),
              CustomElevatedButton(
                onTap: _saveDetails,
                text: "SAVE DETAILS",
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kOffBlack,
                    side: const BorderSide(color: kFireOpal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: kNunitoSansSemiBold18.copyWith(
                      color: kFireOpal,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
