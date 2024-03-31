// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously, unused_field, unused_import

import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rickshare/Views/Loginscrn.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rickshare/Views/Homescrn.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rickshare/variables.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController otpController = TextEditingController();
  bool _isPlaying = true;
  late AnimationController _controller;

  String port = ip;

  Future<void> verifyOTP(String otp, String email) async {
    final url = "$port/verify-otp";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"otp": otp, "email": email}),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginscrn()),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Imvalid OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
    _controller.duration = const Duration(
        milliseconds: 5000); // set the duration according to your animation
    _controller.forward(); // start the animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 153, 0, 1),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 229, 0, 1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(-5, -5),
                  blurRadius: 8,
                  inset: true,
                ),
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(5, 0),
                  blurRadius: 8,
                  inset: true,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height / 12 + 30,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   icon: const Icon(
                    //     Icons.arrow_back,
                    //     color: Colors.black,
                    //     size: 30,
                    //   ),
                    // ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Text(
                              'Enter your verification code',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    )
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Lottie.asset(
                      'assets/lottie/otp3.json',
                      controller: _controller,
                      animate: _isPlaying,
                      height: 140,
                      width: 140,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(255, 229, 0, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(-3, -3),
                            blurRadius: 8,
                            inset: true,
                          ),
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(3, 3),
                            blurRadius: 8,
                            inset: true,
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: 300, // Increase width as needed
                        height: 150, // Decrease height as needed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                style: const TextStyle(
                                    color: Colors.black, fontFamily: 'Inter'),
                                controller: otpController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Enter your code here',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontFamily: 'Inter'),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                ),
                                onChanged: (value) {
                                  // You can add any custom logic here if needed
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Verify OTP
                          String otp = otpController.text;
                          verifyOTP(otp, widget.email);
                        },
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
