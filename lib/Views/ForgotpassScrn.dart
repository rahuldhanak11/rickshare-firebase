// ignore_for_file: use_build_context_synchronously, avoid_print, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rickshare/Views/Loginscrn.dart';
import 'package:http/http.dart' as http;
import 'package:rickshare/variables.dart';

class ForgetpassScrn extends StatefulWidget {
  const ForgetpassScrn({super.key});

  @override
  State<ForgetpassScrn> createState() => _ForgetpassScrnState();
}

class _ForgetpassScrnState extends State<ForgetpassScrn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool obscure_Text = true;
  String port = ip;

  Future<void> changePass(String email, String pass, String cnfPass) async {
    final url = "$port/forgotpasswd";
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
                  Text("Processing..."),
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
          "email": email,
          "password": pass,
          "confirmPassword": cnfPass,
        }),
      );
      Navigator.pop(context); // Close the loading dialog
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Loginscrn(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Password not matched',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
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
                    Center(
                      child: Text(
                        "Forgot",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                    ),
                    Text(
                      "",
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
                    controller: emailController,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
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
                    "New Password",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                  TextField(
                    controller: passController,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    obscureText: obscure_Text,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.tertiary,
                        hintText: "Enter your new password",
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
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                  TextField(
                    controller: confirmPassController,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    obscureText: obscure_Text,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.tertiary,
                        hintText: "Re-enter password",
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
                            Icons.lock_outlined,
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
                      if (passController.text.isEmpty ||
                          confirmPassController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'Please enter your password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      } else if (passController.text ==
                          confirmPassController.text) {
                        await changePass(emailController.text,
                            passController.text, confirmPassController.text);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  const Text('Your password has been changed!'),
                              content: const Text('You can proceed to log in'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Loginscrn()));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Password not matched',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 5.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ),
            // TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) => const Loginscrn()));
            //     },
            //     child: Text(
            //       "Make a new Account",
            //       style: TextStyle(
            //         color: Theme.of(context).colorScheme.secondaryContainer,
            //         fontFamily: 'Inter',
            //         fontSize: 12,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ))
          ],
        ));
  }
}
