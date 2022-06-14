import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/models/user_data.dart';

class UserController extends GetxController {
  final _supabaseClient = Supabase.instance.client;
  UserData userData = UserData();

  Future fetchUserData() async {
    final response = await _supabaseClient
        .from("Users")
        .select(
            "Name, Email, profile_picture_url, sales_notification, delivery_status_notification, new_arrivals_notification")
        .eq("Uid", _supabaseClient.auth.user()?.id)
        .execute();
    userData = UserData.fromJson(response.data[0]);
    update();
  }

  void signOut() {
    kDefaultDialog(
      "Sign out",
      "Are you sure you want to sign out?",
      onYesPressed: () {
        _supabaseClient.auth.signOut();
        Get.deleteAll(force: true);
      },
    );
  }

  Future uploadProfilePicture() async {
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
    final filePath = '${_supabaseClient.auth.currentUser?.id}.$fileExt';
    final response =
        await _supabaseClient.storage.from('profile-pics').uploadBinary(
              filePath,
              bytes,
              fileOptions: const FileOptions(upsert: true),
            );
    if (response.hasError) {
      return;
    }
    final imageUrlResponse =
        _supabaseClient.storage.from('profile-pics').getPublicUrl(filePath);

    //update profile picture url
    userData.profilePictureUrl = imageUrlResponse.data;
    if (userData.profilePictureUrl != null) {
      userData.profilePictureUrl =
          "${userData.profilePictureUrl!}?v=${DateTime.now().toIso8601String()}";
    }
    update();
    await _supabaseClient
        .from("Users")
        .update({"profile_picture_url": imageUrlResponse.data})
        .eq("Uid", _supabaseClient.auth.currentUser?.id)
        .execute();
  }

  Future setSalesNotification(bool val) async {
    userData.salesNotification = val;
    update();
    await _supabaseClient
        .from("Users")
        .update({"sales_notification": val})
        .eq("Uid", _supabaseClient.auth.user()?.id)
        .execute();
  }

  Future setDeliveryStatusNotification(bool val) async {
    userData.deliveryStatusNotification = val;
    update();
    await _supabaseClient
        .from("Users")
        .update({"delivery_status_notification": val})
        .eq("Uid", _supabaseClient.auth.user()?.id)
        .execute();
  }

  Future setNewArrivalsNotification(bool val) async {
    userData.newArrivalsNotification = val;
    update();
    await _supabaseClient
        .from("Users")
        .update({"new_arrivals_notification": val})
        .eq("Uid", _supabaseClient.auth.user()?.id)
        .execute();
  }

  Future setName(String name) async {
    userData.name = name;
    update();
    await _supabaseClient
        .from("Users")
        .update({"Name": name})
        .eq("Uid", _supabaseClient.auth.user()?.id)
        .execute();
    Get.back();
  }

  void resetPassword() {
    kDefaultDialog(
      "Change Password",
      "Are you sure do you want to change your password?",
      onYesPressed: () async {
        Get.back();
        await _supabaseClient.auth.api.resetPasswordForEmail(userData.email);
        Get.snackbar("Reset Password",
            "Your Password reset request has been sent to your email successfully");
      },
    );
  }
}
