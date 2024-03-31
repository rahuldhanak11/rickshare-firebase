// ignore_for_file: file_names, unnecessary_import, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/widgets.dart' hide BoxDecoration, BoxShadow;
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rickshare/variables.dart';

class Profilescrn extends StatefulWidget {
  const Profilescrn({super.key});

  @override
  State<Profilescrn> createState() => _ProfilescrnState();
}

class _ProfilescrnState extends State<Profilescrn> {
  String? token;
  String? firstName;
  String? lastName;
  String? contact;
  String? gender;
  String? email;
  String port = ip;

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch profile data when the widget initializes
  }

  Future<void> fetchProfileData() async {
    await fetchToken();
    print(token);
    if (token != null) {
      final response = await http.get(
        Uri.parse('$port/user/profile'),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          firstName = data['firstName'];
          lastName = data['lastName'];
          contact = data['contact'];
          gender = data['gender'];
          email = data['email'];
        });
      } else {
        // Handle error
      }
    }
  }

  Future<void> fetchToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedToken = prefs.getString('token');
    setState(() {
      token = storedToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Profile',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Expanded(
                  child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                // child: const Text(
                //   "Vector png",
                //   style: TextStyle(color: Colors.black),
                // ),
              )),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.35,
                left: MediaQuery.of(context).size.width / 25,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                    color: Color.fromRGBO(255, 153, 0, 1),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width - 35,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 40, 25.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$firstName',
                              // 'Rahul',
                              style: GoogleFonts.epilogue(
                                color: Colors.black,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              '$lastName',
                              // 'Dhanak',
                              style: GoogleFonts.epilogue(
                                color: Colors.black,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Contact",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Inter'),
                                ),
                                Text(
                                  "$contact",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Inter'),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Gender",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Inter'),
                                ),
                                Text(
                                  "$gender",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Inter'),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                )),
                            Text("$email",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(255, 229, 0, 1),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35.0, vertical: 15.0)),
                              onPressed: () {},
                              child: Text(
                                "Feedback",
                                style: GoogleFonts.epilogue(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                    color: Colors.black),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
