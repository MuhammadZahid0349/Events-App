import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Controller/data_controller.dart';
import 'package:event_management/Models/Events_Model.dart';
import 'package:event_management/Models/Service.dart';
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
import 'package:video_thumbnail/video_thumbnail.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  DateTime? date = DateTime.now();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController maxEntries = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController frequencyEventController = TextEditingController();
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);

  var selectedFrequency = -2;

  void resetControllers() {
    dateController.clear();
    timeController.clear();
    titleController.clear();
    locationController.clear();
    priceController.clear();
    descriptionController.clear();
    tagsController.clear();
    maxEntries.clear();
    endTimeController.clear();
    startTimeController.clear();
    frequencyEventController.clear();
    startTime = TimeOfDay(hour: 0, minute: 0);
    endTime = TimeOfDay(hour: 0, minute: 0);
    // media.clear();
    media.length == 0;
    setState(() {});
  }

  var isCreatingEvent = false.obs;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
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
      date = DateTime(picked.year, picked.month, picked.day, date!.hour,
          date!.minute, date!.second);
      dateController.text = '${date!.day}-${date!.month}-${date!.year}';
    }
    setState(() {});
  }

  startTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
      startTime = picked;
      startTimeController.text =
          '${startTime.hourOfPeriod > 9 ? "" : '0'}${startTime.hour > 12 ? '${startTime.hour - 12}' : startTime.hour}:${startTime.minute > 9 ? startTime.minute : '0${startTime.minute}'} ${startTime.hour > 12 ? 'PM' : 'AM'}';
    }
    print("start ${startTimeController.text}");
    setState(() {});
  }

  endTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
      endTime = picked;
      endTimeController.text =
          '${endTime.hourOfPeriod > 9 ? "" : "0"}${endTime.hour > 9 ? "" : "0"}${endTime.hour > 12 ? '${endTime.hour - 12}' : endTime.hour}:${endTime.minute > 9 ? endTime.minute : '0${endTime.minute}'} ${endTime.hour > 12 ? 'PM' : 'AM'}';
    }

    print(endTime.hourOfPeriod);
    setState(() {});
  }

  String event_type = 'Public';
  List<String> list_item = ['Public', 'Private'];

  String accessModifier = 'Closed';
  List<String> close_list = [
    'Closed',
    'Open',
  ];

  List<Map<String, dynamic>> mediaUrls = [];
  List<EventMediaModel> media = [];

  // List<File> media = [];
  // List thumbnail = [];
  // List<bool> isImage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeController.text = '${date!.hour}:${date!.minute}:${date!.second}';
    dateController.text = '${date!.day}-${date!.month}-${date!.year}';
  }

/////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          // height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Column(
              children: [
                iconWithTitle(text: 'Create Event', func: () {}),
                15.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(horizontal: 15.h),
                        width: 90,
                        height: 33,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: MColor.withOpacity(0.6),
                                    width: 0.6))),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: MColor,
                            size: 30.sp,
                          ),
                          elevation: 16,
                          style: GoogleFonts.josefinSans(
                            color: MColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16.sp,
                          ),
                          value: event_type,
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                event_type = newValue!;
                              },
                            );
                          },
                          items: list_item
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                15.h.heightBox,
                Container(
                  height: Get.width * 0.6,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.white,
                        Colors.grey.withOpacity(0.3),
                        Colors.white,
                      ]),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: DottedBorder(
                    color: MColor,
                    strokeWidth: 2,
                    dashPattern: [6, 6],
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          25.h.heightBox,
                          Container(
                            width: 75.w,
                            height: 60.h,
                            child: Image.asset(
                              'assets/images/uploadIcon.png',
                              color: MColor,
                            ),
                          ),
                          10.h.heightBox,
                          TextStyled(
                              text: "Click and upload image/video",
                              size: 20.sp,
                              FontWeight: FontWeight.w800),
                          10.h.heightBox,
                          Container(
                            width: 135.w,
                            height: 40.h,
                            child: CustomButton(
                              letterSpacing: 3,
                              onPressed: () async {
                                mediaDialog(context);
                              },
                              text: "Upload",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // media.length == 0 ? Container() : 20.h.heightBox,
                20.h.heightBox,

                media.length == 0
                    ? Container()
                    : Container(
                        width: Get.width,
                        height: Get.width * 0.3,
                        child: ListView.builder(
                          itemCount: media.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
                            return media[i].isVideo!
                                //!isImage[i]
                                ? Container(
                                    width: Get.width * 0.3,
                                    height: Get.width * 0.3,
                                    margin: EdgeInsets.only(
                                        right: 15.h, bottom: 10.w, top: 10.w),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              MemoryImage(media[i].thumbnail!),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Stack(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: GestureDetector(
                                                onTap: () {
                                                  media.removeAt(i);
                                                  setState(() {});
                                                },
                                                child: CircleAvatar(
                                                  radius: 15.r,
                                                  backgroundColor: MColor,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.slow_motion_video_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: Get.width * 0.3,
                                    height: Get.width * 0.3,
                                    margin: EdgeInsets.only(
                                        right: 15.h, bottom: 10.w, top: 10.w),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(media[i].image!),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: GestureDetector(
                                            onTap: () {
                                              media.removeAt(i);
                                              setState(() {});
                                            },
                                            child: CircleAvatar(
                                              radius: 15.r,
                                              backgroundColor: MColor,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 15.sp,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),

                10.h.heightBox,
                Container(
                  height: 45.h,
                  child: CustomizedTextfield(
                    myController: titleController,
                    hintText: "Event Name",
                    isprefix: true,
                    prefixImage: "assets/e/g.png",
                  ),
                ),
                15.h.heightBox,
                Container(
                  height: 45.h,
                  child: CustomizedTextfield(
                    myController: locationController,
                    hintText: "Location",
                    isprefix: true,
                    prefixImage: "assets/e/w.png",
                  ),
                ),
                15.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                      isReadOnly: true,
                      path: 'assets/e/l.png',
                      text: 'Date',
                      controller: dateController,
                      validator: (input) {
                        if (date == null) {
                          CustomizedSnackBar("Opps", "Date is required");
                          return '';
                        }
                        return null;
                      },
                      onPress: () {
                        _selectDate(context);
                      },
                    ),
                    iconTitleContainer(
                        path: 'assets/e/h.png',
                        text: 'Max Entries',
                        controller: maxEntries,
                        type: TextInputType.number,
                        onPress: () {},
                        validator: (String input) {
                          if (input.isEmpty) {
                            CustomizedSnackBar("Opps", "Entries is required.");
                            return '';
                          }
                          return null;
                        }),
                  ],
                ),
                15.h.heightBox,
                Container(
                  height: 45.h,
                  child: CustomizedTextfield(
                    myController: tagsController,
                    hintText: "Enter tags that will go with event",
                    isprefix: true,
                    prefixImage: "assets/e/h.png",
                  ),
                ),

                15.h.heightBox,

                Container(
                    height: 45.h,
                    child: CustomizedTextfield(
                      myController: frequencyEventController,
                      prefixImage: "assets/e/f.png",
                      hintText: "Frequency of event",
                      isprefix: true,
                      isReadOnly: true,
                      ontap: () {
                        Get.bottomSheet(StatefulBuilder(builder: (ctx, state) {
                          return _BottomSheetContainer(state);
                        }));
                      },
                    )),
                15.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                        path: 'assets/e/t.png',
                        text: 'Start Time',
                        controller: startTimeController,
                        isReadOnly: true,
                        validator: (input) {},
                        onPress: () {
                          startTimeMethod(context);
                        }),
                    iconTitleContainer(
                        path: 'assets/e/t.png',
                        text: 'End Time',
                        isReadOnly: true,
                        controller: endTimeController,
                        validator: (input) {},
                        onPress: () {
                          endTimeMethod(context);
                        }),
                  ],
                ),
                25.h.heightBox,
                TextStyled(
                    text: "Description / Instruction",
                    FontWeight: FontWeight.w700,
                    size: 20.sp),

                25.h.heightBox,
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(width: 1, color: MColor),
                  ),
                  child: TextFormField(
                    maxLines: 5,
                    controller: descriptionController,
                    validator: (input) {
                      if (input!.isEmpty) {
                        CustomizedSnackBar("Opps", "Description is required.");

                        return '';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 25.w, left: 15.h, right: 15.h),
                      // hintStyle: TextStyle(
                      //   color: MColor,
                      // ),
                      hintText:
                          'Write a summary and any details your invitee should know about the event...',
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8.0),
                      // ),
                    ),
                  ),
                ),
                20.h.heightBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: TextStyled(
                      text: 'Who can invite?',
                      FontWeight: FontWeight.w700,
                      size: 20.sp),
                ),
                15.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      width: 150,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: MColor),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        //borderRadius: BorderRadius.circular(10),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: MColor,
                          size: 25.sp,
                        ),
                        elevation: 16,
                        style: GoogleFonts.josefinSans(
                          color: MColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                        value: accessModifier,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              accessModifier = newValue!;
                            },
                          );
                        },
                        items: close_list
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA6A6A6),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    iconTitleContainer(
                        path: 'assets/e/p.png',
                        text: 'price',
                        type: TextInputType.number,
                        height: 40.h,
                        controller: priceController,
                        onPress: () {},
                        validator: (String input) {
                          if (input.isEmpty) {
                            CustomizedSnackBar("Opps", "Price is required.");
                            return '';
                          }
                        })
                  ],
                ),
                30.h.heightBox,
                CustomButton(
                    onPressed: () async {
                      // if (!formKey.currentState!.validate()) {
                      //   return;
                      // }
                      if (media.isEmpty || tagsController.text.isEmpty) {
                        Get.snackbar('Opps', "Media is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        CustomizedSnackBar("Opps", "Fields are Empty!!!");
                        return;
                      }
                      // isCreatingEvent(true);
                      EasyLoading.show();
                      DataController dataController = Get.find();
                      if (media.isNotEmpty) {
                        for (int i = 0; i < media.length; i++) {
                          if (media[i].isVideo!) {
                            /// if video then first upload video file and then upload thumbnail and
                            /// store it in the map
                            String thumbnailUrl = await dataController
                                .uploadThumbnailToFirebase(media[i].thumbnail!);

                            String videoUrl = await dataController
                                .uploadImageToFirebase(media[i].video!);

                            mediaUrls.add({
                              'url': videoUrl,
                              'thumbnail': thumbnailUrl,
                              'isImage': false
                            });
                          } else {
                            /// just upload image

                            String imageUrl = await dataController
                                .uploadImageToFirebase(media[i].image!);
                            mediaUrls.add({'url': imageUrl, 'isImage': true});
                          }
                        }
                      }

                      List<String> tags = tagsController.text.split(',');

                      firestore_set("events", currentUserData, {
                        'event': event_type,
                        'event_name': titleController.text,
                        'location': locationController.text,
                        'date': '${date!.day}-${date!.month}-${date!.year}',
                        'start_time': startTimeController.text,
                        'end_time': endTimeController.text,
                        'max_entries': int.parse(maxEntries.text),
                        'frequency_of_event': frequencyEventController.text,
                        'description': descriptionController.text,
                        'who_can_invite': accessModifier,
                        'joined': [auth.currentUser!.uid],
                        'price': priceController.text,
                        'media': mediaUrls,
                        'uid': auth.currentUser!.uid,
                        'tags': tags,
                        'inviter': [auth.currentUser!.uid]
                      });
                      EasyLoading.dismiss();
                      CustomizedSnackBar(
                          "Event Uploaded", "Event is uploaded successfully");
                      resetControllers();

                      // await dataController
                      //     .createEvent(eventData)
                      //     .then((value) {
                      //   print("Event is done");
                      //   // isCreatingEvent(false);
                      // });
                    },
                    text: "Create Event"),

                30.h.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _BottomSheetContainer(StateSetter state) {
    return Container(
      width: double.infinity,
      height: Get.width * 0.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            // mainAxisAlignment:
            //     MainAxisAlignment.spaceAround,
            children: [
              selectedFrequency == 10
                  ? Container()
                  : SizedBox(
                      width: 5,
                    ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  selectedFrequency = -1;

                  state(() {});
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.w),
                  decoration: BoxDecoration(
                    color: selectedFrequency == -1
                        ? MColor
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: TextStyled(
                        text: "Once",
                        size: 17.sp,
                        color: selectedFrequency != -1 ? MColor : Colors.white,
                        FontWeight: FontWeight.w700),
                  ),
                ),
              )),
              selectedFrequency == 10 ? Container() : 5.w.widthBox,
              Expanded(
                  child: InkWell(
                onTap: () {
                  selectedFrequency = 0;

                  state(() {});
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.w),
                  decoration: BoxDecoration(
                    color: selectedFrequency == 0
                        ? MColor
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: TextStyled(
                        text: "Daily",
                        size: 17.sp,
                        color: selectedFrequency != 0 ? MColor : Colors.white,
                        FontWeight: FontWeight.w700),
                  ),
                ),
              )),
              selectedFrequency == 10 ? Container() : 10.w.widthBox,
              Expanded(
                  child: InkWell(
                onTap: () {
                  state(() {
                    selectedFrequency = 1;
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: selectedFrequency == 1
                        ? MColor
                        : Colors.black.withOpacity(0.1),
                  ),
                  child: Center(
                    child: TextStyled(
                        text: "Weekly",
                        size: 17.sp,
                        color: selectedFrequency != 1 ? MColor : Colors.white,
                        FontWeight: FontWeight.w700),
                  ),
                ),
              )),
              selectedFrequency == 10 ? Container() : 10.w.widthBox,
            ],
          ),
          Row(
            // mainAxisAlignment:
            //     MainAxisAlignment.spaceAround,
            children: [
              selectedFrequency == 10 ? Container() : 10.w.widthBox,
              Expanded(
                  child: InkWell(
                onTap: () {
                  state(() {
                    selectedFrequency = 2;
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: selectedFrequency == 2
                        ? MColor
                        : Colors.black.withOpacity(0.1),
                  ),
                  child: Center(
                    child: TextStyled(
                        text: "Monthly",
                        size: 17.sp,
                        color: selectedFrequency != 2 ? MColor : Colors.white,
                        FontWeight: FontWeight.w700),

                    // Text(
                    //   "Monthly",
                    //   style: TextStyle(
                    //       color: selectedFrequency != 2
                    //           ? Colors.black
                    //           : Colors.white),
                    // ),
                  ),
                ),
              )),
              selectedFrequency == 10 ? Container() : 10.w.widthBox,
              Expanded(
                  child: InkWell(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: selectedFrequency == 3
                        ? MColor.withOpacity(0.7)
                        : Colors.black.withOpacity(0.1),
                  ),
                  child: Center(
                    child: TextStyled(
                        text: "Yearly",
                        size: 17.sp,
                        color: selectedFrequency != 3 ? MColor : Colors.white,
                        FontWeight: FontWeight.w700),
                    // Text(
                    //   "Yearly",
                    //   style: TextStyle(
                    //       color: selectedFrequency != 3
                    //           ? Colors.black
                    //           : Colors.white),
                    // ),
                  ),
                ),
                onTap: () {
                  state(() {
                    selectedFrequency = 3;
                  });
                },
              )),
              selectedFrequency == 10 ? Container() : 5.w.widthBox
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: Get.width * 0.8,
                height: 40.h,
                child: CustomButton(
                    onPressed: () {
                      frequencyEventController.text = selectedFrequency == -1
                          ? 'Once'
                          : selectedFrequency == 0
                              ? 'Daily'
                              : selectedFrequency == 1
                                  ? 'Weekly'
                                  : selectedFrequency == 2
                                      ? 'Monthly'
                                      : 'Yearly';
                      Get.back();
                    },
                    text: "Select"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getImageDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: source,
    );

    if (image != null) {
      media.add(EventMediaModel(
          image: File(image.path), video: null, isVideo: false));
    }

    setState(() {});
    Navigator.pop(context);
  }

  getVideoDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? video = await _picker.pickVideo(
      source: source,
    );

    if (video != null) {
      // media.add(File(image.path));

      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: video.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );

      media.add(EventMediaModel(
          thumbnail: uint8list!, video: File(video.path), isVideo: true));
      // thumbnail.add(uint8list!);
      //
      // isImage.add(false);
    }

    // print(thumbnail.first.path);
    setState(() {});

    Navigator.pop(context);
  }

  void mediaDialog(BuildContext context) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextStyled(
                text: "Select Media Type",
                size: 25.sp,
                FontWeight: FontWeight.w700),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, true);
                    },
                    icon: Icon(
                      Icons.image,
                      color: MColor,
                      size: 40.sp,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, false);
                    },
                    icon: Icon(
                      Icons.slow_motion_video_outlined,
                      color: MColor,
                      size: 40.sp,
                    )),
              ],
            ),
          );
        },
        context: context);
  }

  void imageDialog(BuildContext context, bool image) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextStyled(
                text: "Media Source", size: 25.sp, FontWeight: FontWeight.w700),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.gallery);
                      } else {
                        getVideoDialog(ImageSource.gallery);
                      }
                    },
                    icon: Icon(
                      Icons.image,
                      color: MColor,
                      size: 40.sp,
                    )),
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.camera);
                      } else {
                        getVideoDialog(ImageSource.camera);
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: MColor,
                      size: 40.sp,
                    )),
              ],
            ),
          );
        },
        context: context);
  }
}
