import 'package:event_management/Constants/utils.dart';
import 'package:event_management/Controller/data_controller.dart';
import 'package:event_management/Models/Service.dart';
import 'package:event_management/Screen/Event/Create_Event_View.dart';
import 'package:event_management/Screen/Home_Bottom_Menu.dart';
import 'package:event_management/Screen/Profile%20Screens/Create_Profile.dart';
import 'package:event_management/Screen/Profile%20Screens/Profile_Screen.dart';
import 'package:event_management/Screen/onboarding_Screen.dart';
import 'package:event_management/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(DataController());
  runApp(MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-V-M',
            builder: EasyLoading.init(),
            home:
                // ProfileScreen()
                auth.currentUser == null
                    ? OnBoradingScreen()
                    : HomeBottomMenuBar(),
          );
        });
  }
}
