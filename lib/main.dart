import 'package:firebase_core/firebase_core.dart';
import 'package:project_management/app/login/screens/home.dart';

import 'app/config/routes/app_pages.dart';
import 'app/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/login/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAKKcVY2qktvq_Cm1_wTqpJGRqIqE5R3Gg",
          projectId: "herafy-983de",
          messagingSenderId: "1088905524845",
          appId: "1:1088905524845:web:a402d7112952c24da4b164",
        storageBucket: "herafy-983de.appspot.com",

      ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Project Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.basic,
      // initialRoute: AppPages.initialHome,
      getPages: AppPages.routes,

      home: const LoginScreen(),
    );
  }
}
