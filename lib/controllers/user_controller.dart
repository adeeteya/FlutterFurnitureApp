import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/models/user_data.dart';
import 'package:timberr/screens/authentication/onboarding_welcome.dart';

class UserController extends GetxController {
  final _supabaseClient = Supabase.instance.client;
  UserData userData = UserData();

  Future<void> fetchUserData() async {
    final response = await _supabaseClient
        .from("Users")
        .select(
            "Name, Email, profile_picture_url, sales_notification, delivery_status_notification, new_arrivals_notification")
        .eq("Uid", _supabaseClient.auth.currentUser!.id);
    userData = UserData.fromJson(response[0]);
    update();
  }

  void signOut() {
    kDefaultDialog(
      "Sign out",
      "Are you sure you want to sign out?",
      onYesPressed: () async {
        await _supabaseClient.auth.signOut();
        await Get.deleteAll(force: true);
        Get.offAll(() => const OnBoardingWelcomeScreen());
      },
    );
  }

  Future<void> uploadProfilePicture() async {
    bool exit = true;
    await kDefaultDialog(
      "Change Picture",
      "Do you want to change your profile picture?",
      onYesPressed: () {
        exit = false;
        Get.back();
      },
    );
    if (exit) return;
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }
    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final filePath = '${_supabaseClient.auth.currentUser!.id}.$fileExt';
    await _supabaseClient.storage.from('profile-pics').uploadBinary(
          filePath,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );
    //TODO: Handle Upload Profile pic Error
    final imageUrlResponse =
        _supabaseClient.storage.from('profile-pics').getPublicUrl(filePath);

    //update profile picture url
    userData.profilePictureUrl = imageUrlResponse;
    if (userData.profilePictureUrl != null) {
      userData.profilePictureUrl =
          "${userData.profilePictureUrl!}?v=${DateTime.now().toIso8601String()}";
    }
    update();
    await _supabaseClient
        .from("Users")
        .update({"profile_picture_url": imageUrlResponse}).eq(
            "Uid", _supabaseClient.auth.currentUser!.id);
  }

  Future<void> setSalesNotification(bool val) async {
    userData.salesNotification = val;
    update();
    await _supabaseClient.from("Users").update({"sales_notification": val}).eq(
        "Uid", _supabaseClient.auth.currentUser!.id);
  }

  Future<void> setDeliveryStatusNotification(bool val) async {
    userData.deliveryStatusNotification = val;
    update();
    await _supabaseClient
        .from("Users")
        .update({"delivery_status_notification": val}).eq(
            "Uid", _supabaseClient.auth.currentUser!.id);
  }

  Future<void> setNewArrivalsNotification(bool val) async {
    userData.newArrivalsNotification = val;
    update();
    await _supabaseClient
        .from("Users")
        .update({"new_arrivals_notification": val}).eq(
            "Uid", _supabaseClient.auth.currentUser!.id);
  }

  Future<void> setName(String name) async {
    userData.name = name;
    update();
    await _supabaseClient
        .from("Users")
        .update({"Name": name}).eq("Uid", _supabaseClient.auth.currentUser!.id);
    Get.back();
  }

  void resetPassword() {
    kDefaultDialog(
      "Change Password",
      "Are you sure do you want to change your password?",
      onYesPressed: () async {
        Get.back();
        await _supabaseClient.auth.resetPasswordForEmail(userData.email);
        Get.snackbar("Reset Password",
            "Your Password reset request has been sent to your email successfully");
      },
    );
  }
}
