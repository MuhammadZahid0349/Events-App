import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Models/Service.dart';
import 'package:event_management/Screen/Auth/SignUpScreen.dart';
import 'package:event_management/Screen/Home_Screen.dart';
import 'package:event_management/Widgets/customized_textfield.dart';
import 'package:event_management/Widgets/customized_textformfield.dart';
import 'package:event_management/Widgets/customizted_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController forgetEmailController = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    forgetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Column(
              children: [
                60.h.heightBox,
                Text('Login',
                    style: GoogleFonts.josefinSans(
                      color: MColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 35.sp,
                    )),
                20.h.heightBox,
                Text(
                    'Welcome back, Please Login and continue your journey with us.',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                        color: MColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                        height: 1.2.h)),
                35.h.heightBox,
                Container(
                  height: 50.h,
                  child: CustomizedTextFormfield(
                    myController: _emailController,
                    isPassword: false,
                    hintText: "zahid@gmail.com",
                  ),
                ),
                20.h.heightBox,
                Container(
                  height: 50.h,
                  child: CustomizedTextFormfield(
                    myController: _passwordController,
                    isPassword: true,
                    hintText: "Password",
                  ),
                ),
                20.h.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          titlePadding: EdgeInsets.only(top: 15.w),
                          title: 'Forget Password',
                          titleStyle: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w900,
                            fontSize: 22.sp,
                          ),
                          content: Container(
                            width: Get.width,
                            child: Column(
                              children: [
                                15.h.heightBox,
                                Container(
                                  height: 50.h,
                                  child: CustomizedTextFormfield(
                                    myController: forgetEmailController,
                                    isPassword: false,
                                    hintText: "zahid@gmail.com",
                                  ),
                                ),
                                30.h.heightBox,
                                CustomButton(
                                    onPressed: () {
                                      forgetPassword(
                                          forgetEmailController.text.trim());
                                      forgetEmailController.clear();
                                    },
                                    text: "Send"),
                              ],
                            ),
                          ));
                    },
                    child: Text('Forgot password?',
                        style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w900,
                            fontSize: 16.sp,
                            height: 1.5,
                            color: MColor,
                            decorationThickness: 2,
                            decoration: TextDecoration.underline)),
                  ),
                ),
                35.h.heightBox,
                CustomButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        return CustomizedSnackBar(
                            "Empty", "Kindly Fill the Fields");
                      } else {
                        login(_emailController.text.trim(),
                            _passwordController.text.trim());
                      }
                    },
                    text: "Login"),
                30.h.heightBox,
                Text('Or Connect With',
                    style: GoogleFonts.josefinSans(
                      color: MColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                      letterSpacing: 5,
                    )),
                25.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialAppsIcons(
                        onPressed: () {
                          // Get.to(()=> ProfileScreen());
                        },
                        iconData: FontAwesomeIcons.facebookF),
                    socialAppsIcons(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        iconData: FontAwesomeIcons.google),
                  ],
                ),
                20.h.heightBox,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Don't have an Account?",
                          softWrap: true,
                          style: GoogleFonts.josefinSans(
                            color: MColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUpScreen());
                        },
                        child: Text("Register Now",
                            softWrap: true,
                            style: GoogleFonts.josefinSans(
                                color: MColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.sp,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2)),
                      ),
                    ],
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
