// ignore_for_file: file_names, unnecessary_import, non_constant_identifier_names, avoid_print, unused_import, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rickshare/Views/Loginscrn.dart';
import 'package:rickshare/Views/OTPScreen.dart';
import 'package:rickshare/rick_share_icons.dart';
import 'package:rickshare/variables.dart';

class Signupscrn extends StatefulWidget {
  const Signupscrn({super.key});

  @override
  State<Signupscrn> createState() => _SignupscrnState();
}

class _SignupscrnState extends State<Signupscrn> {
  bool obscure_Text = true;
  bool flag = false;
  String errorMessage = "";
  String errorMessagepass = '';
  String port = ip;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  void checkEmail() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Please enter an email.';
        flag = true;
      });
    } else {
      RegExp regex = RegExp(r'^[\w-\.]+@somaiya.edu$');
      if (regex.hasMatch(email)) {
        setState(() {
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Email must end with @somaiya.edu';
        });
      }
    }
  }

  void checkpassword() {
    String password = passwordController.text.trim();
    if (password.isEmpty) {
      setState(() {
        errorMessagepass = 'Please enter an password.';
        flag = true;
      });
    } else {
      errorMessagepass = '';
    }
  }

  Future<void> signUp(String firstName, String lastName, String email,
      String password, String number) async {
    final url = "$port/register";
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Logging in..."),
                ],
              ),
            ),
          );
        },
      );
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email.toLowerCase(),
          "password": password,
          "number": number,
        }),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OTPScreen(email: email),
          ),
        );
        print("User Registered");
      } else {
        Navigator.pop(context);
        print("User not Registered");
      }
    } catch (e) {
      print('Error: $e');
      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: 'An error occurred',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 55,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        ),
                        Text(
                          "Unlock new Experience",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 2.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: TextField(
                              controller: firstNameController,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                hintText: "First Name",
                                hintStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.tertiary,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: TextField(
                              controller: lastNameController,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                hintText: "Last Name",
                                hintStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.tertiary,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 2.0),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        ),
                      ),
                      TextField(
                        controller: numberController,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            hintText: "Enter your Mobile Number",
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
                                Icons.phone_rounded,
                                size: 25,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 2.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        onChanged: (value) {
                          checkEmail();
                        },
                        decoration: InputDecoration(
                            errorText: errorMessage,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            hintText: "Enter your email",
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
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 2.0),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          checkpassword();
                        },
                        controller: passwordController,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        obscureText: obscure_Text,
                        decoration: InputDecoration(
                            errorText: errorMessagepass,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
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
                          if (flag == false &&
                              errorMessage !=
                                  'Email must end with @somaiya.edu') {
                            await signUp(
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              passwordController.text,
                              numberController.text,
                            );
                          } else {
                            // Handle case when form validation fails or email is not valid
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          elevation: 5.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                        ),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Loginscrn()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                      child: Text(
                        "Already Registered? Log in here.",
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
