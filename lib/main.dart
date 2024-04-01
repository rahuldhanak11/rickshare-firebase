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
import 'package:firebase_core/firebase_core.dart';
import 'package:rickshare/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  
  runApp(const MyApp());
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
