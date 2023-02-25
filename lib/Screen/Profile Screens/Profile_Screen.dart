import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Controller/data_controller.dart';
import 'package:event_management/Models/Service.dart';
import 'package:event_management/Models/ticket_model.dart';
import 'package:event_management/Screen/Profile%20Screens/Edit_Profile.dart';
import 'package:event_management/Widgets/customizted_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  List<Ticketdetail> ticket = [
    Ticketdetail(
        color: Color(0xffADD8E6),
        date: 'Feb 28',
        range: '10-11',
        name: 'BRUNCH',
        img1: 'assets/images/#1.png',
        img2: 'assets/images/#2.png',
        img3: 'assets/images/#3.png',
        img4: 'assets/images/#1.png',
        img5: 'assets/images/#3.png',
        img6: 'assets/images/#3.png',
        heart: 'assets/images/heart.png',
        count: '5.2k',
        message: 'assets/images/message.png',
        rate: '140',
        share: 'assets/images/send.png'),
    Ticketdetail(
        color: Color(0xff0000FF),
        date: 'may 14',
        range: '6-7:30',
        name: 'BRUNCH',
        img1: 'assets/images/#1.png',
        img2: 'assets/images/#2.png',
        img3: 'assets/images/#3.png',
        img4: 'assets/images/#1.png',
        img5: 'assets/images/#3.png',
        img6: 'assets/images/#3.png',
        heart: 'assets/images/heart2.png',
        count: '5.2k',
        message: 'assets/images/message.png',
        rate: '150',
        share: 'assets/images/send.png'),
  ];

  bool isNotEditable = true;

  DataController? dataController;

  int? followers = 0, following = 0;
  String image = '';

  String? fName;
  String? lName;
  String? location;
  String? desc;

  // @override
  // initState() {
  //   super.initState();

  // dataController = Get.find<DataController>();

  // fName = dataController?.myDocument!.get('first');
  // lName = dataController?.myDocument!.get('last');
  // desc = dataController?.myDocument!.get('desc');
  // location = dataController?.myDocument!.get('location');
  // try {
  //   image = dataController?.myDocument!.get('userPicture');
  // } catch (e) {
  //   image = '';
  // }

  // followers = dataController?.myDocument!.get('followers').length;
  // following = dataController?.myDocument!.get('following').length;
  // }

  @override
  Widget build(BuildContext context) {
    // var screenheight = MediaQuery.of(context).size.height;
    // var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.only(
                      left: Get.width * 0.75, top: 10, right: 20),
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.sms_rounded,
                          color: MColor,
                          size: 25.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.menu,
                          color: MColor,
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 90.w, horizontal: 20.h),
                  width: Get.width,
                  height: isNotEditable ? 240.h : 310.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.35),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 120.w,
                        height: 120.h,
                        margin: EdgeInsets.only(top: 35.w),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: MColor,
                          borderRadius: BorderRadius.circular(70),
                          gradient: LinearGradient(
                            colors: [
                              MColor,
                              Color(0xff7DDCFB),
                              MColor,
                              Colors.white,
                              MColor
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(70.r),
                              ),
                              child: image.isEmpty
                                  ? CircleAvatar(
                                      radius: 55.r,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPyGNr2qL63Sfugk2Z1-KBEwMGOfycBribew&usqp=CAU")
                                      // child: ClipOval(
                                      //   child: Image.network(
                                      //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPyGNr2qL63Sfugk2Z1-KBEwMGOfycBribew&usqp=CAU",
                                      //     fit: BoxFit.cover,
                                      //     height: 80.h,
                                      //   ),
                                      // ),
                                      )
                                  // backgroundImage: AssetImage(
                                  //   'assets/images/profile.png',
                                  // ))
                                  : CircleAvatar(
                                      radius: 55.r,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                        image,
                                      )),
                              // child: Image.asset(
                              //   'assets/profilepic.png',
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    15.h.heightBox,
                    isNotEditable
                        ? TextStyled(
                            text: "User Name",
                            size: 17.sp,
                            FontWeight: FontWeight.w700)
                        // Text(
                        //     "${firstNameController.text} ${lastNameController.text}",
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       color: MColor,
                        //       fontWeight: FontWeight.w700,
                        //     ),
                        //   )

                        : Container(
                            width: Get.width * 0.6,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: firstNameController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'First Name',
                                    ),
                                  ),
                                ),
                                10.w.widthBox,
                                Expanded(
                                  child: TextField(
                                    controller: lastNameController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Last Name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    3.h.heightBox,
                    isNotEditable
                        ? TextStyled(
                            text: "Location",
                            size: 17.sp,
                            FontWeight: FontWeight.w700)
                        : Container(
                            width: Get.width * 0.6,
                            child: TextField(
                              controller: locationController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Location',
                              ),
                            ),
                          ),
                    15.h.heightBox,
                    isNotEditable
                        ? Container(
                            height: 50.h,
                            width: 270.w,
                            child: TextStyled(
                                text:
                                    "The key to your success on Fiverr is the brand you build for yourself through your Fiverr reputation",
                                size: 15.sp,
                                FontWeight: FontWeight.w700)
                            // Text(
                            //   '${descriptionController.text}',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     letterSpacing: -0.3,
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w300,
                            //   ),
                            // ),
                            )
                        : Container(
                            width: Get.width * 0.6,
                            child: TextField(
                              controller: descriptionController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Description',
                              ),
                            ),
                          ),
                    15.h.heightBox,
                    /////////////////////////////////
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              TextStyled(
                                  text: "${followers}",
                                  size: 17.sp,
                                  FontWeight: FontWeight.w700),
                              Padding(
                                padding: EdgeInsets.only(top: 3.w),
                                child: TextStyled(
                                    text: "Followers",
                                    size: 12.sp,
                                    FontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Container(
                            width: 2.w,
                            height: 35.h,
                            color: MColor.withOpacity(0.5),
                          ),
                          Column(
                            children: [
                              TextStyled(
                                  text: "${following}",
                                  size: 17.sp,
                                  FontWeight: FontWeight.w700),
                              Padding(
                                padding: EdgeInsets.only(top: 3.w),
                                child: TextStyled(
                                    text: "Following",
                                    size: 12.sp,
                                    FontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Container(
                              height: 30.h,
                              width: 80.w,
                              child: CustomButton(
                                onPressed: () {},
                                text: "Follow",
                                letterSpacing: 0,
                                size: 10.sp,
                              ))
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 10),
                    //   width: Get.width * 0.6,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Container(
                    //         width: 34,
                    //         height: 34,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(36),
                    //           color: Color(0xffE2E2E2),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(5),
                    //           child: Icon(
                    //             Icons.add,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 34,
                    //         height: 34,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(36),
                    //           color: AppColors.blue,
                    //         ),
                    //         child: Image(
                    //           image: AssetImage('assets/#1.png'),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 34,
                    //         height: 34,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(36),
                    //           color: AppColors.blue,
                    //         ),
                    //         child: Image(
                    //           image: AssetImage('assets/#3.png'),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 34,
                    //         height: 34,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(36),
                    //           color: AppColors.blue,
                    //         ),
                    //         child: Image(
                    //           image: AssetImage('assets/#2.png'),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 34,
                    //         height: 34,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(36),
                    //           color: AppColors.blue,
                    //         ),
                    //         child: Image(
                    //           image: AssetImage('assets/#3.png'),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 34,
                    //         height: 34,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(36),
                    //           color: AppColors.blue,
                    //         ),
                    //         child: Image(
                    //           image: AssetImage('assets/#1.png'),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    40.h.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 52.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36.r),
                                border: Border.all(color: MColor, width: 2.w),
                              ),
                              child: Icon(
                                Icons.add,
                                color: MColor,
                                size: 25.sp,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              width: 53.w,
                              height: 53.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.r),
                                  border: Border.all(color: MColor, width: 2.w),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image(
                                    image:
                                        AssetImage('assets/Ellipse 984.png')),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 30.h, top: 10.w),
                            child: TextStyled(
                                text: "NEW",
                                size: 12.sp,
                                FontWeight: FontWeight.w700)),
                      ],
                    ),
                    8.h.heightBox,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.h),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: MColor,
                                    width: 0.01.w,
                                  ),
                                ),
                              ),
                              child: TabBar(
                                indicatorColor: MColor,
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 20.h,
                                  vertical: 10.w,
                                ),
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    icon:
                                        Image.asset("assets/images/ticket.png"),
                                    height: 25.h,
                                  ),
                                  Tab(
                                    icon: Image.asset(
                                        "assets/images/Group 18600.png"),
                                    height: 25.h,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: Get.height * 0.46,
                              //height of TabBarView
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: ticket.length,
                                      itemBuilder: (context, index) {
                                        return
                                            // InkWell(onTap: (){
                                            // Get.to(()=>Detailproduct(record: popular[index],));
                                            // },
                                            Container(
                                          margin: EdgeInsets.only(top: 20.w),
                                          width: 388.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 4, color: Colors.white),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.20),
                                                spreadRadius: 2,
                                                blurRadius: 3,
                                                offset: Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 50.w,
                                                  height: 41.h,
                                                  padding: EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      6.r,
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          ticket[index].color!,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextStyled(
                                                          text: ticket[index]
                                                              .range,
                                                          size: 11.sp,
                                                          FontWeight:
                                                              FontWeight.w600),
                                                      TextStyled(
                                                          text: ticket[index]
                                                              .date,
                                                          size: 10.sp,
                                                          FontWeight:
                                                              FontWeight.w600),
                                                    ],
                                                  ),
                                                ),
                                                10.w.widthBox,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextStyled(
                                                        text:
                                                            '${ticket[index].name}',
                                                        size: 16.sp,
                                                        FontWeight:
                                                            FontWeight.w900),
                                                    15.h.heightBox,
                                                    Row(
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].img1}'),
                                                          width: 27.w,
                                                          height: 27.h,
                                                        ),
                                                        1.w.widthBox,
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].img2}'),
                                                          width: 27.w,
                                                          height: 27.h,
                                                        ),
                                                        1.w.widthBox,
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].img3}'),
                                                          width: 27.w,
                                                          height: 27.h,
                                                        ),
                                                        1.w.widthBox,
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].img4}'),
                                                          width: 27.w,
                                                          height: 27.h,
                                                        ),
                                                        1.w.widthBox,
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].img5}'),
                                                          width: 27.w,
                                                          height: 27.h,
                                                        ),
                                                        1.w.widthBox,
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].img6}'),
                                                          width: 27.w,
                                                          height: 27.h,
                                                        ),
                                                      ],
                                                    ),
                                                    10.h.heightBox,
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 30.h,
                                                          child: Image.asset(
                                                            ticket[index].heart,
                                                          ),
                                                        ),
                                                        1.w.widthBox,
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: TextStyled(
                                                              text:
                                                                  '${ticket[index].count}',
                                                              size: 13.sp,
                                                              FontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        23.w.widthBox,
                                                        Image(
                                                          image: AssetImage(
                                                              '${ticket[index].message}'),
                                                          width: 16.w,
                                                          height: 16.h,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: TextStyled(
                                                              text:
                                                                  '${ticket[index].rate}',
                                                              size: 13.sp,
                                                              FontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        27.w.widthBox,
                                                        Container(
                                                            child: Image(
                                                          image: AssetImage(
                                                              '${ticket[index].share}'),
                                                          width: 15.w,
                                                          height: 15.h,
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  Container(
                                    child: Center(
                                      child: TextStyled(
                                          text: "Tab 2",
                                          size: 13.sp,
                                          FontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 105.w, right: 35.h),
                  child: GestureDetector(
                    onTap: () {
                      // Get.to(() => EditProfile());

                      // if (isNotEditable == false) {
                      //   FirebaseFirestore.instance
                      //       .collection('users')
                      //       .doc(FirebaseAuth.instance.currentUser!.uid)
                      //       .set({
                      //     'first': firstNameController.text,
                      //     'last': lastNameController.text,
                      //     'location': locationController.text,
                      //     'desc': descriptionController.text
                      //   }, SetOptions(merge: true)).then((value) {
                      //     Get.snackbar('Profile Updated',
                      //         'Profile has been updated successfully.',
                      //         colorText: Colors.white,
                      //         backgroundColor: Colors.blue);
                      //   });
                      // }

                      // setState(() {
                      //   isNotEditable = !isNotEditable;
                      // });
                    },
                    child: isNotEditable
                        ? Image(
                            image: AssetImage('assets/images/edit.png'),
                            width: Get.width * 0.04,
                          )
                        : Icon(
                            Icons.check,
                            color: MColor,
                            size: 25.sp,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
