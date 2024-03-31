// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, use_build_context_synchronously, unused_import

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rickshare/Views/ForgotpassScrn.dart';
import 'package:rickshare/Views/Homescrn.dart';
// import 'package:rickshare/Views/OTPScreen.dart';
import 'package:rickshare/Views/Signupscrn.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rickshare/Views/loadingscreen1.dart';
import 'package:rickshare/rick_share_icons.dart';
import 'package:rickshare/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rickshare/auth.dart';

class Loginscrn extends StatefulWidget {
  const Loginscrn({super.key});

  @override
  State<Loginscrn> createState() => _LoginscrnState();
}

class _LoginscrnState extends State<Loginscrn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool obscure_Text = true;

  Future<void> _login() async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);

      // User is successfully logged in
      // Navigate to HomeScreen or perform any other action

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Homescrn(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                Text(
                  "You have been missed!",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              TextField(
                controller: _emailController,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.tertiary,
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                      color: Colors.black,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.mail_outline_rounded,
                        size: 25,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              TextField(
                controller: _passwordController,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
                obscureText: obscure_Text,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.tertiary,
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: 25,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                      child: IconButton(
                        icon: Icon(
                          obscure_Text
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure_Text = !obscure_Text;
                          });
                        },
                      ),
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          child: SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: () async {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 5.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                ),
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(50, 30),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ForgetpassScrn()));
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Signupscrn()));
            },
            child: Text(
              "Create an account",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )),
      ],
    ));
  }
}
