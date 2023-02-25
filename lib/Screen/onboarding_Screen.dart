import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Screen/Auth/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class OnBoradingScreen extends StatelessWidget {
  const OnBoradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                45.h.heightBox,
                Text("Welcome to EVM",
                    style: GoogleFonts.josefinSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 24.sp,
                      letterSpacing: 7,
                    )),
                15.h.heightBox,
                Text("Event Management System",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp,
                      letterSpacing: 4,
                    )),
                45.h.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  child: Image.asset("assets/onboardIcon.png"),
                ),
                45.h.heightBox,
                Expanded(
                  child: Container(
                    // height: 300.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.r,
                              spreadRadius: 3.r)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // 20.h.heightBox,
                          Text(
                              "The social media platform designed to get you offline",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.josefinSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.sp,
                                  height: 1.2.h)),
                          // 20.h.heightBox,
                          Text(
                              "EVM is an app where users can leverage their social network to create, discover, share, and monetize events or services.",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              )),
                          // 20.h.heightBox,
                          Padding(
                            padding: EdgeInsets.only(bottom: 30.w),
                            child: MaterialButton(
                              height: 40.h,
                              minWidth: Get.width,
                              color: Colors.white,
                              elevation: 3,
                              onPressed: () {
                                Get.to(() => MyLoginPage());
                              },
                              child: Text("Get Started",
                                  style: GoogleFonts.josefinSans(
                                    color: MColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                    letterSpacing: 5,
                                  )),
                            ),
                          ),
                        ],
                      ),
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
