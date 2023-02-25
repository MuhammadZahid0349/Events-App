import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Models/Service.dart';
import 'package:event_management/Screen/Auth/Login_Screen.dart';
import 'package:event_management/Screen/Home_Screen.dart';
import 'package:event_management/Screen/Profile%20Screens/Create_Profile.dart';
import 'package:event_management/Widgets/customized_textformfield.dart';
import 'package:event_management/Widgets/customizted_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Column(
              children: [
                60.h.heightBox,
                Text('Sign Up',
                    style: GoogleFonts.josefinSans(
                      color: MColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 35.sp,
                    )),
                20.h.heightBox,
                Text(
                    'Welcome, Please Sign up to see events and classes from your friends.',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                        color: MColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                        height: 1.2.h)),
                ///////////////////////////
                25.h.heightBox,
                Container(
                  height: 50.h,
                  child: CustomizedTextFormfield(
                    myController: emailController,
                    isPassword: false,
                    hintText: "Email",
                  ),
                ),
                20.h.heightBox,
                Container(
                  height: 50.h,
                  child: CustomizedTextFormfield(
                    myController: passwordController,
                    isPassword: true,
                    hintText: "Password",
                  ),
                ),
                20.h.heightBox,
                Container(
                  height: 50.h,
                  child: CustomizedTextFormfield(
                    myController: confirmPasswordController,
                    isPassword: true,
                    hintText: "Confirm Password",
                  ),
                ),
                30.h.heightBox,
                CustomButton(
                    onPressed: () {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        signUp(emailController.text.trim(),
                            passwordController.text.trim());
                      } else {
                        CustomizedSnackBar(
                            "Password", "Incorrect-Password!!!!");
                      }
                    },
                    text: "Sign Up"),
                20.h.heightBox,
                Text('Or Connect With',
                    style: GoogleFonts.josefinSans(
                      color: MColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                      letterSpacing: 5,
                    )),
                20.h.heightBox,
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
                Container(
                    width: Get.width,
                    child: RichText(
                      softWrap: true,
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'By signing up, you agree our ',
                            style: GoogleFonts.josefinSans(
                              color: MColor.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            )),
                        TextSpan(
                            text: 'terms, Data policy and cookies policy',
                            style: GoogleFonts.josefinSans(
                              color: MColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp,
                            )),
                      ]),
                    )),
                20.h.heightBox,

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Already have an Account?",
                          softWrap: true,
                          style: GoogleFonts.josefinSans(
                            color: MColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => MyLoginPage());
                        },
                        child: Text("Login Now",
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
                10.h.heightBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
