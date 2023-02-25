import 'package:event_management/Constants/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  // final TextInputType? inputType;
  final bool? isprefix;
  final bool? isReadOnly;
  final String? prefixImage;
  final VoidCallback? ontap;
  final Color? BordColor;

  const CustomizedTextfield({
    Key? key,
    required this.myController,
    this.hintText,
    this.isprefix,
    this.prefixImage,
    this.ontap,
    this.isReadOnly,
    this.BordColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly == true ? true : false,
      onTap: ontap,
      style: GoogleFonts.josefinSans(
          color: MColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          height: 2),
      textAlignVertical: TextAlignVertical.center,
      controller: myController,
      decoration: InputDecoration(
        prefixIcon: isprefix == true
            ? Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset(
                  prefixImage!,
                  color: MColor.withOpacity(0.8),
                  height: 20,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: BordColor ?? MColor, width: 1.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: BordColor ?? MColor, width: 1.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        contentPadding: EdgeInsets.all(10),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
