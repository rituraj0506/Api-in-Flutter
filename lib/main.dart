import 'package:first_app/Intropage.dart';
import 'package:first_app/firstpage.dart';
import 'package:first_app/home_screen.dart';
import 'package:first_app/imagepage.dart';
import 'package:first_app/loginpage.dart';
import 'package:first_app/productpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  home: HomeScreen(),
      //home: Intropage(),
      // home: Firstpage(),
      //home: Loginpage(),
      // home: Loginpage(),
      //home: Productpage(),
      home: Imagepage(),
    );
  }
}
