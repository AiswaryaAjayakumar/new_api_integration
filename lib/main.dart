// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:new_api_integration/controller/business_screen_controller.dart';
import 'package:new_api_integration/controller/home_screen_controller.dart';
import 'package:new_api_integration/controller/sports_controller.dart';
import 'package:new_api_integration/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BusinessController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SportsController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
