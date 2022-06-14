import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/wrapper.dart';

class AuthController extends GetxController {
  final _authController = Supabase.instance;
  User? get user => _authController.client.auth.currentUser;

  Future signIn(String email, String password) async {
    final response = await _authController.client.auth
        .signIn(email: email, password: password);
    if (response.error != null) {
      kDefaultDialog(
          "Error", response.error?.message ?? 'Some Unknown Error occurred');
    } else {
      // Sign in with success
      Get.offAll(() => const Wrapper());
    }
  }

  Future signUp(String name, String email, String password) async {
    final response = await _authController.client.auth.signUp(email, password);
    if (response.error != null &&
        response.error!.message !=
            'Thanks for registering, now check your email to complete the process.') {
      // Handle error
      kDefaultDialog(
        "Error",
        response.error?.message ?? 'Some Unknown Error occurred',
      );
    } else {
      // check is session is null(user already exists) else sign in
      if (response.data == null) {
        kDefaultDialog("Error", "User already Exists");
      } else {
        _authController.client.from('Users').insert({
          'Name': name,
          'Email': email,
          'Uid': response.user!.id,
          'favoritesList': [],
          'cartList': [],
        }).execute();
        Get.offAll(() => const Wrapper());
      }
    }
  }

  Future forgotPassword(String email) async {
    await _authController.client.auth.api.resetPasswordForEmail(email);
    Get.snackbar("Password reset",
        "Password reset request has been sent to your email successfully.");
  }
}
