import 'package:event_management/Constants/ColorConstants.dart';
import 'package:event_management/Screen/Community_Screen.dart';
import 'package:event_management/Screen/Event/Create_Event_View.dart';
import 'package:event_management/Screen/Home_Screen.dart';
import 'package:event_management/Screen/Profile%20Screens/Profile_Screen.dart';
import 'package:event_management/Screen/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomMenuBar extends StatefulWidget {
  HomeBottomMenuBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomMenuBar> createState() => _HomeBottomMenuBarState();
}

class _HomeBottomMenuBarState extends State<HomeBottomMenuBar> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> widgetOption = [
    HoomeScreen(),
    CommunityScreen(),
    CreateEventView(),
    MessageScreen(),
    ProfileScreen()
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Get.put(DataController(),permanent: true);
  //       FirebaseMessaging.instance.getInitialMessage();
  //   FirebaseMessaging.onMessage.listen((message) {

  //     LocalNotificationService.display(message);
  //   });

  // LocalNotificationService.storeToken();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          // height: 50,
          child: BottomNavigationBar(
            onTap: onItemTapped,
            selectedItemColor: MColor,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset(
                      currentIndex == 0
                          ? 'assets/images/Group 43 (1).png'
                          : 'assets/images/Group 43.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset(
                      currentIndex == 1
                          ? 'assets/images/Group 18340 (1).png'
                          : 'assets/images/Group 18340.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset(
                        currentIndex == 2
                            ? 'assets/images/Group 18528 (1).png'
                            : 'assets/images/Group 18528.png',
                        width: 22,
                        height: 22),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset(
                        currentIndex == 3
                            ? 'assets/images/Group 18339 (1).png'
                            : 'assets/images/Group 18339.png',
                        width: 22,
                        height: 22),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset(
                      currentIndex == 4
                          ? 'assets/images/Group 18341 (1).png'
                          : 'assets/images/Group 18341.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  label: ''),
            ],
          ),
        ),
        body: widgetOption[currentIndex]);
  }
}
