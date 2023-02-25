import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Models/Service.dart';
import 'package:event_management/Screen/Home_Bottom_Menu.dart';
import 'package:event_management/Widgets/customized_textfield.dart';
import 'package:event_management/Widgets/customizted_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class CProfileScreen extends StatefulWidget {
  CProfileScreen({super.key});

  @override
  State<CProfileScreen> createState() => _CProfileScreenState();
}

class _CProfileScreenState extends State<CProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1980),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: MColor, // <-- SEE HERE
                    onPrimary: Colors.white, // <-- SEE HERE
                    onSurface: MColor, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: MColor, // button text color
                    ),
                  )),
              child: child!);
        });
    if (picked != null) {
      dob.text = '${picked.day}-${picked.month}-${picked.year}';
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dob = TextEditingController();

  File? profileImage;

  imagePickDialog() {
    Get.defaultDialog(
        titlePadding: EdgeInsets.only(top: 15.w),
        title: 'Choose Image Source',
        titleStyle: GoogleFonts.josefinSans(
          fontWeight: FontWeight.w800,
          color: MColor,
          fontSize: 22.sp,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  profileImage = File(image.path);
                  setState(() {});
                  // Navigator.pop(context);
                  Get.back();
                }
              },
              child: Icon(
                Icons.camera_alt,
                size: 30.sp,
              ),
            ),
            20.w.widthBox,
            GestureDetector(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  profileImage = File(image.path);
                  setState(() {});
                  Get.back();
                }
              },
              child: SvgPicture.asset(
                "assets/svg/gallery.svg",
                height: 30.sp,
                width: 30.sp,
              ),
            ),
          ],
        ));
  }

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Column(
                children: [
                  50.h.heightBox,
                  Stack(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            imagePickDialog();
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 2.w),
                            decoration: BoxDecoration(
                              color: MColor,
                              borderRadius: BorderRadius.circular(70.r),
                              gradient: LinearGradient(
                                colors: [
                                  MColor,
                                  Colors.white,
                                  Colors.grey,
                                  Colors.white,
                                  MColor.withOpacity(0.5)
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.h, vertical: 2.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(67.r),
                                  ),
                                  child: profileImage == null
                                      ? CircleAvatar(
                                          radius: 56.r,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: MColor,
                                            size: 50.sp,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 56.r,
                                          backgroundColor: Colors.white,
                                          backgroundImage: FileImage(
                                            profileImage!,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () {
                              Get.offAll(() => HomeBottomMenuBar());
                            },
                            child: TextStyled(
                                text: "Skip->",
                                FontWeight: FontWeight.w900,
                                size: 20.sp)),
                      )
                    ],
                  ),
                  25.h.heightBox,
                  Container(
                    height: 50.h,
                    child: CustomizedTextfield(
                      myController: firstNameController,
                      hintText: "First Name",
                    ),
                  ),
                  15.h.heightBox,
                  Container(
                    height: 50.h,
                    child: CustomizedTextfield(
                      myController: lastNameController,
                      hintText: "Last Name",
                    ),
                  ),
                  15.h.heightBox,
                  Container(
                    height: 50.h,
                    child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                        ],
                        // text: 'Mobile Number',
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MColor, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MColor, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        controller: mobileNumberController,
                        validator: (String? input) {
                          if (mobileNumberController.text.isEmpty) {
                            CustomizedSnackBar(
                                "Mobile Number", "Required your Mobile Number");
                            return '';
                          }
                          if (mobileNumberController.text.length == 11) {
                            CustomizedSnackBar(
                                "Mobile Number", "Enter valid phone number!!!");
                            return '';
                          }
                        }),
                  ),
                  15.h.heightBox,
                  Container(
                    height: 50.h,
                    child: TextField(
                      controller: dob,
                      // enabled: false,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MColor, width: 1.w),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MColor, width: 1.w),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: MColor,
                          size: 30.sp,
                        ),
                        hintText: 'Date Of Birht',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        child: RadioListTile(
                          activeColor: MColor,
                          title: Text('Male',
                              style: GoogleFonts.josefinSans(
                                color: MColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 20.sp,
                              )),
                          value: 0,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val!);
                          },
                        ),
                      )),
                      Expanded(
                        child: Container(
                          child: RadioListTile(
                            activeColor: MColor,
                            title: Text('Female',
                                style: GoogleFonts.josefinSans(
                                  color: MColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.sp,
                                )),
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: (int? val) {
                              setSelectedRadio(val!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  25.h.heightBox,
                  CustomButton(
                      onPressed: () async {
                        if (dob.text.isEmpty &&
                            firstNameController.text.isEmpty &&
                            lastNameController.text.isEmpty &&
                            profileImage == null) {
                          CustomizedSnackBar(
                              "Warning", "Fill the Profile Data!!!");
                          return;
                        }
                        if (profileImage == null) {
                          CustomizedSnackBar(
                              "Warning", "Fill the Profile Data!!!");
                          return null;
                        }
                        // EasyLoading.show();
                        String imageUrl =
                            await uploadImageToFirebaseStorage(profileImage!);

                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(currentUserData)
                            .update({
                          "userFName": firstNameController.text.trim(),
                          "userLName": lastNameController.text.trim(),
                          "userPNumber": mobileNumberController.text.trim(),
                          "userDOB": dob.text.trim(),
                          "gender": selectedRadio == 0 ? "Male" : "Female",
                          "userPicture": imageUrl
                        }).then((value) {
                          CustomizedSnackBar("Profile", "Data has been saved");
                        }).catchError((e) {
                          CustomizedSnackBar("Warning", e);
                          print(e);
                        });

                        // try {
                        //   firestore_update(
                        //       "users",
                        //       currentUserData,
                        //       ({
                        //         "userFName": firstNameController.text.trim(),
                        //         "userLName": lastNameController.text.trim(),
                        //         "userPNumber":
                        //             mobileNumberController.text.trim(),
                        //         "userDOB": dob.text.trim(),
                        //         "gender":
                        //             selectedRadio == 0 ? "Male" : "Female",
                        //         "userPicture": imageUrl
                        //       }));
                        //   EasyLoading.dismiss();
                        //   Get.offAll(() => HomeBottomMenuBar());
                        // } catch (e) {
                        //   CustomizedSnackBar("Warning", e);
                        // }
                      },
                      text: "Save"),
                  40.h.heightBox,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
