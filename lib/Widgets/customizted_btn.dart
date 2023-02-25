import 'package:event_management/Constants/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final double? letterSpacing;
  final double? size;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.letterSpacing,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.withOpacity(0.3)]),
          border: Border.all(color: MColor),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: Center(
            child: Text(text.toUpperCase(),
                softWrap: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  color: MColor,
                  fontWeight: FontWeight.w800,
                  fontSize: size ?? 17.sp,
                  letterSpacing: letterSpacing ?? 10,
                )),
          )),
    );
  }
}
