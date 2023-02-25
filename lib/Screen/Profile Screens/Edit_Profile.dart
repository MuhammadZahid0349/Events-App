// import 'dart:io';

// import 'package:event_management/Constants/ColorConstants.dart';
// import 'package:event_management/Constants/utils.dart';
// import 'package:event_management/Models/Service.dart';
// import 'package:event_management/Widgets/customized_textfield.dart';
// import 'package:event_management/Widgets/customizted_btn.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:velocity_x/velocity_x.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController lcoationController = TextEditingController();
//   TextEditingController descController = TextEditingController();

//   File? profileImage;

//   imagePickDialog() {
//     Get.defaultDialog(
//         titlePadding: EdgeInsets.only(top: 15.w),
//         title: 'Choose Image Source',
//         titleStyle: GoogleFonts.josefinSans(
//           fontWeight: FontWeight.w800,
//           color: MColor,
//           fontSize: 22.sp,
//         ),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 final ImagePicker _picker = ImagePicker();
//                 final XFile? image =
//                     await _picker.pickImage(source: ImageSource.camera);
//                 if (image != null) {
//                   profileImage = File(image.path);
//                   setState(() {});
//                   // Navigator.pop(context);
//                   Get.back();
//                 }
//               },
//               child: Icon(
//                 Icons.camera_alt,
//                 size: 30.sp,
//               ),
//             ),
//             20.w.widthBox,
//             GestureDetector(
//               onTap: () async {
//                 final ImagePicker _picker = ImagePicker();
//                 final XFile? image = await _picker.pickImage(
//                   source: ImageSource.gallery,
//                 );
//                 if (image != null) {
//                   profileImage = File(image.path);
//                   setState(() {});
//                   Get.back();
//                 }
//               },
//               child: SvgPicture.asset(
//                 "assets/svg/gallery.svg",
//                 height: 30.sp,
//                 width: 30.sp,
//               ),
//             ),
//           ],
//         ));
//   }

//   void setSelectedRadio(int val) {
//     setState(() {
//       selectedRadio = val;
//     });
//   }

//   int selectedRadio = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         height: Get.height,
//         width: Get.width,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               MColor,
//               Colors.white,
//               Colors.white,
//               Colors.white,
//               Colors.white,
//               Colors.white,
//               MColor
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.h),
//             child: Column(
//               children: [
//                 50.h.heightBox,
//                 Stack(
//                   children: [
//                     Center(
//                       child: GestureDetector(
//                         onTap: () {
//                           imagePickDialog();
//                         },
//                         child: Container(
//                           width: 120,
//                           height: 120,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 2.h, vertical: 2.w),
//                           decoration: BoxDecoration(
//                             color: MColor,
//                             borderRadius: BorderRadius.circular(70.r),
//                             gradient: LinearGradient(
//                               colors: [
//                                 MColor,
//                                 Colors.white,
//                                 Colors.grey,
//                                 Colors.white,
//                                 MColor.withOpacity(0.5)
//                               ],
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 2.h, vertical: 2.w),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade200,
//                                   borderRadius: BorderRadius.circular(67.r),
//                                 ),
//                                 child: profileImage == null
//                                     ? CircleAvatar(
//                                         radius: 56.r,
//                                         backgroundColor: Colors.white,
//                                         child: Icon(
//                                           Icons.camera_alt,
//                                           color: MColor,
//                                           size: 50.sp,
//                                         ),
//                                       )
//                                     : CircleAvatar(
//                                         radius: 56.r,
//                                         backgroundColor: Colors.white,
//                                         backgroundImage: FileImage(
//                                           profileImage!,
//                                         ),
//                                       ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: GestureDetector(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: Container(
//                               height: 30.h,
//                               child: Image.asset("assets/Header.png"))),
//                     )
//                   ],
//                 ),
//                 25.h.heightBox,
//                 Container(
//                   height: 50.h,
//                   child: CustomizedTextfield(
//                     myController: firstNameController,
//                     hintText: "First Name",
//                   ),
//                 ),
//                 15.h.heightBox,
//                 Container(
//                   height: 50.h,
//                   child: CustomizedTextfield(
//                     myController: lastNameController,
//                     hintText: "Last Name",
//                   ),
//                 ),
//                 15.h.heightBox,
//                 Container(
//                   height: 50.h,
//                   child: CustomizedTextfield(
//                     myController: lcoationController,
//                     hintText: "Location",
//                   ),
//                 ),
//                 15.h.heightBox,
//                 Container(
//                   height: 150.h,
//                   child: TextField(
//                     maxLines: 5,
//                     style: GoogleFonts.josefinSans(
//                         color: MColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18.sp,
//                         height: 2),
//                     textAlignVertical: TextAlignVertical.center,
//                     controller: descController,
//                     decoration: InputDecoration(
//                       isDense: true,
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: MColor, width: 1.w),
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: MColor, width: 1.w),
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       contentPadding: EdgeInsets.all(10),
//                       hintText: "Description",
//                       // hintStyle: TextStyle(color: Colors.white),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                     ),
//                   ),
//                 ),
//                 25.h.heightBox,
//                 CustomButton(onPressed: () async {}, text: "Update"),
//                 40.h.heightBox,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
