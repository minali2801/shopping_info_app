import 'package:appforhelp/controller/category_controller.dart';
import 'package:appforhelp/views/screens/authentication_screens/login_screen.dart';
import 'package:appforhelp/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // check the user is loggedIn or not using sharedPreffremce
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // hrere get the value of login user
  Platform.isAndroid
      ? await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyD6DFDyPWbumodkt0JwBAgRx-wMWFvJt3M',
          appId: '1:598593522771:android:0b094b9cdfc2f05b858aa6',
          messagingSenderId: '59859352277',
          projectId: 'my-app-fa4eb',
        ),
      )
      : await Firebase.initializeApp();
  runApp(ScreenUtilInit(
    designSize: Size(375,812),
    minTextAdapt: true,
    splitScreenMode: true,
    child: ProviderScope(child: MyApp(isLoggedIn: isLoggedIn,))));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn ? MainScreen() : LoginScreen(),
      initialBinding:BindingsBuilder(() {
      Get.put<CategoryController>(CategoryController());
      })
    );
  }
}