import 'package:assess_anime/controller/app_controller.dart';
import 'package:assess_anime/core/colors/colors.dart';
import 'package:assess_anime/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/main_page/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => AppController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.black,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
