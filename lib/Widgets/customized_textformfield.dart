import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedTextFormfield extends StatefulWidget {
  final TextEditingController myController;
  final String? hintText;
  final bool? isPassword;

  const CustomizedTextFormfield(
      {Key? key, required this.myController, this.hintText, this.isPassword})
      : super(key: key);

  @override
  State<CustomizedTextFormfield> createState() =>
      _CustomizedTextFormfieldState();
}

class _CustomizedTextFormfieldState extends State<CustomizedTextFormfield> {
  bool _isVisible = false;

  void _showPassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.isPassword!
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      enableSuggestions: widget.isPassword! ? false : true,
      // autocorrect: widget.isPassword! ? false : true,
      obscureText: _isVisible ? false : widget.isPassword!,

      controller: widget.myController,
      validator: widget.isPassword!
          ? (value) {
              if (value!.isEmpty) {
                return CustomizedSnackBar(
                    'Password', 'Please Enter Password!!');
              } else if (value.length < 6) {
                return CustomizedSnackBar(
                    "Password", 'Password must be greater then 6...');
              }
              return null;
            }
          : (value) {
              if (value!.isEmpty) {
                return CustomizedSnackBar('Warning', 'Email is required.');
              } else if (!value.contains('@')) {
                return CustomizedSnackBar('Warning', 'Email is invalid.');
              } else if (!value.contains('.com')) {
                return CustomizedSnackBar('Warning', 'Email is invalid.');
              }
              return null;
            },
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.isPassword! ? 'Password' : 'Email:',
        labelStyle: TextStyle(color: MColor),
        suffixIcon: widget.isPassword!
            ? IconButton(
                color: MColor,
                icon: Icon(
                    _isVisible ? Icons.remove_red_eye : Icons.visibility_off),
                onPressed: () => _showPassword(),
              )
            : Icon(
                Icons.mail,
                color: MColor,
              ),
        // errorText: ,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MColor, width: 1.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        ////////////////////////////////
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MColor, width: 1.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
