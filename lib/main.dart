// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_api_integration/controller/home_screen_controller.dart';
//import 'package:new_api_integration/controller/search_screen_controller.dart';
import 'package:new_api_integration/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAfI2WelVw9hrJ8-Hqn7y8EOQLh34gqX4I",
          appId: "1:706390932467:android:46dfae5254b5cafdf33086",
          messagingSenderId: "",
          projectId: "sampleprjct-9c728",
          storageBucket: "sampleprjct-9c728.appspot.com"));
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
