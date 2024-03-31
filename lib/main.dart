// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:rickshare/Theme.dart';
import 'package:rickshare/Views/Chatboxscrn.dart';
import 'package:rickshare/Views/ForgotpassScrn.dart';
import 'package:rickshare/Views/Homescrn.dart';
import 'package:rickshare/Views/Loginscrn.dart';
import 'package:rickshare/Views/OTPScreen.dart';
import 'package:rickshare/Views/Pingscrn.dart';
import 'package:rickshare/Views/Profile.dart';
import 'package:rickshare/Views/Reportpage.dart';
import 'package:rickshare/Views/Splashscrn.dart';
import 'package:rickshare/Views/Welcomescrn.dart';
import 'package:rickshare/Views/Signupscrn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightmode,
      darkTheme: darkMode,
      home: const Loginscrn(),
    );
  }
}
