// ignore_for_file: unused_import, avoid_print, file_names, unused_local_variable, use_build_context_synchronously

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:rickshare/Views/Chatboxscrn.dart';
import 'package:rickshare/Views/Homescrn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rickshare/variables.dart';

class Reportscrn extends StatefulWidget {
  const Reportscrn({super.key});

  @override
  State<Reportscrn> createState() => _ReportscrnState();
}

class _ReportscrnState extends State<Reportscrn> {
  bool isCheckboxChecked1 = false;
  String port = ip;
  bool isCheckboxChecked2 = false;
  String? token;
  List<String> reasons = [
    'Inappropriate Behavior',
    'Spamming',
    'Violating Community Guidelines',
    'Abusive Language',
    'Impersonation or Misrepresentation',
    'Privacy Concerns',
    'Suspicious Activity',
    'Technical Issues or Bugs',
  ];
  List<String> selectedReasons = [];
  String? additionalInfo;
  List<bool> isSelected = List<bool>.generate(8, (index) => false);
  TextEditingController addinfocontroller = TextEditingController();
  TextEditingController userreportcontroller = TextEditingController();

  Future<void> sendReportDetails() async {
    await fetchToken();
    print(token);
    if (token != null) {
      final response = await http.post(
        Uri.parse('$port/report'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "list": selectedReasons,
          "extraInfo": additionalInfo,
          "user": userreportcontroller.text
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {});
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
  void initState() {
    super.initState();
    fetchToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            )),
        backgroundColor: const Color.fromRGBO(255, 229, 0, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 0, 2),
              child: Text(
                'Report User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  fontSize: 24.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 0, 20),
              child: Text(
                'Which user do you wish to report?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                ),
              ),
            ),
            TextField(
              controller: userreportcontroller,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'Type the user ID you want to report...',
                border: OutlineInputBorder(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                'Why are you reporting this user?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reasons.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        // borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CheckboxListTile(
                        title: Text(reasons[index]),
                        value: isSelected[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isSelected[index] = value!;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (userreportcontroller.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter the user ID you want to report."),
              ),
            );
            return; // Exit the onPressed function
          }
          bool isAnyOptionSelected = isSelected.contains(true);

          // Perform reporting action here
          if (isAnyOptionSelected) {
            for (int i = 0; i < isSelected.length; i++) {
              if (isSelected[i]) {
                selectedReasons.add(reasons[i]);
              }
            }

            print('Selected reasons: $selectedReasons');
            additionalInfo = addinfocontroller.text;
            print('Additional information: $additionalInfo');

            showDialog(
              context: context,
              barrierDismissible: false, // Prevent dismissing the dialog
              builder: (BuildContext context) {
                return const Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(), // CircularProgressIndicator here
                        SizedBox(height: 16),
                        Text(
                            "Sending report..."), // Text indicating the report is being sent
                      ],
                    ),
                  ),
                );
              },
            );

            // Send report details
            await sendReportDetails();

            // Clear checkbox states
            setState(() {
              isCheckboxChecked1 = false;
              isCheckboxChecked2 = false;
              isSelected = List<bool>.generate(8, (index) => false);
            });

            // Clear text field value
            userreportcontroller.clear();

            Navigator.pop(context);
            // Show dialog box
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Report has been submitted'),
                  content: const Text('Thank you for reporting!'),
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Select at least one option")),
            );
          }
        },
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }
}
