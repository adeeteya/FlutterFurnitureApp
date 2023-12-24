import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/user_controller.dart';
import 'package:timberr/screens/profile/edit_personal_info_screen.dart';
import 'package:timberr/widgets/input/settings_text_box.dart';
import 'package:timberr/widgets/tiles/settings_row_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final UserController _userController = Get.find();
  void _toEditPersonalInfoScreen() {
    Get.to(
      () => const EditPersonalInformationScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  void _toFAQ() {
    launchUrl(Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ"));
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
          "SETTING",
          style: kMerriweatherBold16,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Personal Information",
                    style: kNunitoSansSemiBold16TinGrey,
                  ),
                  IconButton(
                    onPressed: _toEditPersonalInfoScreen,
                    icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                  ),
                ],
              ),
              SettingsTextBox(
                fieldName: "Name",
                value: _userController.userData.name,
              ),
              const SizedBox(height: 15),
              SettingsTextBox(
                fieldName: "Email",
                value: _userController.userData.email,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Password",
                    style: kNunitoSansSemiBold16TinGrey,
                  ),
                  IconButton(
                    onPressed: _userController.resetPassword,
                    icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                  ),
                ],
              ),
              const SettingsTextBox(
                fieldName: "Password",
                value: "*************",
              ),
              const SizedBox(height: 25),
              const Text(
                "Notifications",
                style: kNunitoSansSemiBold16TinGrey,
              ),
              const SizedBox(height: 10),
              SettingRowTile(
                fieldName: "Sales",
                action: CupertinoSwitch(
                  value: controller.userData.salesNotification,
                  onChanged: (val) {
                    controller.setSalesNotification(val);
                  },
                  activeColor: kSeaGreen,
                ),
              ),
              const SizedBox(height: 10),
              SettingRowTile(
                fieldName: "New Arrivals",
                action: CupertinoSwitch(
                  value: controller.userData.newArrivalsNotification,
                  onChanged: (val) {
                    controller.setNewArrivalsNotification(val);
                  },
                  activeColor: kSeaGreen,
                ),
              ),
              const SizedBox(height: 10),
              SettingRowTile(
                fieldName: "Delivery Status",
                action: CupertinoSwitch(
                  value: controller.userData.deliveryStatusNotification,
                  onChanged: (val) {
                    _userController.setDeliveryStatusNotification(val);
                  },
                  activeColor: kSeaGreen,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Help Center",
                style: kNunitoSansSemiBold16TinGrey,
              ),
              const SizedBox(height: 10),
              SettingRowTile(
                fieldName: "FAQ",
                action: GestureDetector(
                  onTap: _toFAQ,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: kTinGrey,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
