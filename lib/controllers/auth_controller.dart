import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/wrapper.dart';

class AuthController extends GetxController {
  final _supabaseInstance = Supabase.instance.client;
  User? get user => _supabaseInstance.auth.currentUser;

  Future signIn(String email, String password) async {
    try {
      await _supabaseInstance.auth
          .signInWithPassword(email: email, password: password);
      // Sign in with success
      Get.offAll(() => const Wrapper());
    } on AuthException catch (error) {
      kDefaultDialog("Error", error.message);
    } catch (error) {
      kDefaultDialog("Error", 'Some Unknown Error occurred');
    }
  }

  Future signUp(String name, String email, String password) async {
    try {
      final response =
          await _supabaseInstance.auth.signUp(password: password, email: email);
      if (response.session != null) {
        await _supabaseInstance.from('Users').insert({
          'Name': name,
          'Email': email,
          'Uid': response.session?.user.id,
          'favoritesList': [],
          'cartList': [],
        });
        Get.offAll(() => const Wrapper());
      }
    } on AuthException catch (error) {
      kDefaultDialog("Error", error.message);
    } catch (error) {
      kDefaultDialog("Error", 'Some Unknown Error occurred');
    }
  }

  Future forgotPassword(String email) async {
    await _supabaseInstance.auth.resetPasswordForEmail(email);
    Get.snackbar("Password reset",
        "Password reset request has been sent to your email successfully.");
  }
}
