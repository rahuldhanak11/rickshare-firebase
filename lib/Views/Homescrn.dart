// ignore: file_names

// ignore_for_file: unused_import, unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rickshare/Views/Chatboxscrn.dart';
import 'package:rickshare/Views/Loginscrn.dart';
import 'package:http/http.dart' as http;
import 'package:rickshare/Views/Profile.dart';
import 'package:rickshare/Views/Welcomescrn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rickshare/variables.dart';

class Homescrn extends StatefulWidget {
  const Homescrn({super.key});

  @override
  State<Homescrn> createState() => _HomescrnState();
}

class _HomescrnState extends State<Homescrn> {
  String? selectedvalue1 = "sion";
  String? selectedvalue2 = "kjsit";
  String port = ip;
  bool? isBan;
  // final AudioPlayer _audioplayer = AudioPlayer();

  String get source {
    if (selectedvalue1 == "sion" && selectedvalue2 == "kjsit") {
      return "Sion";
    } else if (selectedvalue1 == "kjsit" && selectedvalue2 == "sion") {
      return "K. J. Somaiya Institute of Technology";
    }
    return "";
  }

  String get destination {
    if (selectedvalue1 == "sion" && selectedvalue2 == "kjsit") {
      return "K. J. Somaiya Institute of Technology";
    } else if (selectedvalue1 == "kjsit" && selectedvalue2 == "sion") {
      return "Sion";
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
    isBanUser();
  }

  Future<void> isBanUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? storedValue = prefs.getBool('isBan');
    setState(() {
      isBan = storedValue;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    if (token != null) {
      final url = "$port/logout";
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        // Clear token from SharedPreferences
        await prefs.remove('token');
      } else {
        // Handle HTTP error
        print('Error: Request failed with status ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      endDrawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Profilescrn()));
                  },
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      // Adjust the color to match your theme
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                  leading: const Icon(
                    Icons.person,
                    size: 28,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Welcomescrn()));
                  },
                  title: Text(
                    'About App',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      // Adjust the color to match your theme
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                  leading: const Icon(
                    Icons.info,
                    size: 28,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await logout();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Loginscrn()));
                  },
                  title: Text(
                    'Log out',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      // Adjust the color to match your theme
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    size: 28,
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     launchUrl(Uri.file('https://www.instagram.com/rickshare/'));
                //   },
                //   title: Text(
                //     'Instagram',
                //     style: TextStyle(
                //       fontFamily: 'Inter',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 17,

                //       color: Theme.of(context).colorScheme.secondaryContainer,
                //     ),
                //   ),
                //   leading: Icon(
                //     Icons.social_distance
                //   )
                // )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                child: Lottie.asset(
                  'assets/lottie/render.json',
                  height: 220,
                ),
              )
            ],
          )),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Change the color to match your theme
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(8, 8),
                      inset: true,
                    ),
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(-8, 0),
                      inset: true,
                    )
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 30, 0),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          iconEnabledColor: Colors.black,
                          iconSize: 35,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(26)),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "sion",
                              child: Text(
                                "Sion Station",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "kjsit",
                              child: Text(
                                "K. J. Somaiya Institute of Technology",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          value: selectedvalue1,
                          onChanged: (val) {
                            setState(() {
                              selectedvalue1 = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 30, 0),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          iconEnabledColor: Colors.black,
                          iconSize: 35,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(26)),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "sion",
                              child: Text(
                                "Sion Station",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DropdownMenuItem(
                              value: "kjsit",
                              child: Text(
                                "K. J. Somaiya Institute of Technology",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          value: selectedvalue2,
                          onChanged: (val) {
                            setState(() {
                              selectedvalue2 = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -20,
                left: MediaQuery.of(context).size.width * 0.5 - 20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -19,
                left: MediaQuery.of(context).size.width * 0.5 - 19,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary, // Change the color of the new circle
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // _audioplayer.play('assets/ding.mp3', isLocal: true);
                      if (isBan == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  const Text('You have violated our policies'),
                              content: const Text(
                                  'You will not be able to use our services.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        if (selectedvalue1 == selectedvalue2) {
                          Fluttertoast.showToast(
                            msg: "Both Source and Destination can't be Same",
                            toastLength: Toast.LENGTH_LONG,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => chatBoxscrn(
                                source: source,
                                destination: destination,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.location_pin,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
