import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/auth_controller.dart';
import 'package:timberr/screens/authentication/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', password = '', confirmPassword = '';
  bool _showPassword = false;

  void _nameOnChanged(String val) {
    name = val;
  }

  String? _nameValidator(String? val) {
    return name.isNotEmpty ? null : 'Please enter your name';
  }

  void _emailOnChanged(String val) {
    email = val;
  }

  String? _emailValidator(String? val) {
    return (GetUtils.isEmail(val ?? '')) ? null : 'Please enter your email';
  }

  void _passwordOnChanged(String val) {
    password = val;
  }

  String? _passwordValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return 'Please enter a password';
    } else {
      if (val!.length < 6) {
        return 'Password should be at least 6 characters long';
      }
      return null;
    }
  }

  void _confirmPasswordOnChanged(String val) {
    confirmPassword = val;
  }

  String? _confirmPasswordValidator(String? val) {
    return (val == password) ? null : "Passwords do not match";
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      _authController.signUp(name, email, password);
    }
  }

  void _toLoginScreen() {
    Get.off(
      () => const LoginScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Flexible(
                      child: Divider(
                        color: kNoghreiSilver,
                        thickness: 1,
                        indent: 30,
                        endIndent: 20,
                      ),
                    ),
                    SvgPicture.asset("assets/furniture_vector.svg"),
                    const Flexible(
                      child: Divider(
                        color: kNoghreiSilver,
                        thickness: 1,
                        indent: 20,
                        endIndent: 30,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, bottom: 30),
                  child: Text(
                    "WELCOME",
                    style: kMerriweatherBold24,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(right: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x408A959E),
                          offset: Offset(0, 7),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            top: 20,
                          ),
                          child: TextFormField(
                            cursorColor: kOffBlack,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            onChanged: _nameOnChanged,
                            validator: _nameValidator,
                            decoration: inputDecorationConst.copyWith(
                                labelText: "Name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            top: 20,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: kOffBlack,
                            onChanged: _emailOnChanged,
                            validator: _emailValidator,
                            decoration: inputDecorationConst.copyWith(
                                labelText: "Email"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 20),
                          child: TextFormField(
                            onChanged: _passwordOnChanged,
                            validator: _passwordValidator,
                            obscureText: !_showPassword,
                            textInputAction: TextInputAction.next,
                            cursorColor: kOffBlack,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Password",
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: SvgPicture.asset(
                                    "assets/icons/password_visible.svg",
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(maxWidth: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 20),
                          child: TextFormField(
                            onChanged: _confirmPasswordOnChanged,
                            validator: _confirmPasswordValidator,
                            obscureText: !_showPassword,
                            enableSuggestions: false,
                            autocorrect: false,
                            cursorColor: kOffBlack,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Confirm Password",
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: SvgPicture.asset(
                                    "assets/icons/password_visible.svg",
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(maxWidth: 50),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: _signUp,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: kOffBlack,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x50303030),
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "SIGN UP",
                              style: kNunitoSansSemiBold18.copyWith(
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have a account?",
                              style: kNunitoSans14.copyWith(
                                fontWeight: FontWeight.w600,
                                color: kGrey,
                              ),
                            ),
                            TextButton(
                              onPressed: _toLoginScreen,
                              child: Text(
                                "SIGN IN",
                                style: kNunitoSans14.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
