// ignore_for_file: unused_import, library_prefixes, camel_case_types, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, use_super_parameters, file_names, unused_field

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rickshare/Views/Homescrn.dart';
import 'package:http/http.dart' as http;
import 'package:rickshare/Views/Reportpage.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:rickshare/rick_share_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rickshare/variables.dart';

class chatBoxscrn extends StatefulWidget {
  final String source;
  final String destination;

  const chatBoxscrn({required this.source, required this.destination});
  
  
  @override
  State<chatBoxscrn> createState() => _chatBoxscrnState();
}

class _chatBoxscrnState extends State<chatBoxscrn> {
  String port = ip;
  String? token;
  String? cusername;
  String? user1;
  String? user2;
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final List<String> _users = [];
  final ScrollController scrollController = ScrollController();

  // Future<void> fetchUsername() async {
  //   await fetchToken();
  //   print(token);
  //   if (token != null) {
  //     final response = await http.get(
  //       Uri.parse('$port/username'),
  //       headers: {"Authorization": "Bearer $token"},
  //     );
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       setState(() {
  //         cusername = data["username"];
  //       });
  //     } else {
  //       // Handle error
  //     }
  //   }
  // }

  // void _sendMessage() {
  //   String message = _messageController.text.trim();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //   });
  //   if (message.isNotEmpty) {
  //     socket.emit('message', {'message': message});
  //     _messageController.clear();
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   fetchToken().then((_) {
  //     fetchUsername();
  //     if (token != null) {
  //       socket = IO.io(
  //         '$port/chat',
  //         <String, dynamic>{
  //           'transports': ['websocket'],
  //           'autoConnect': false,
  //           'auth': {
  //             'token': token,
  //             'src': widget.source,
  //             'destn': widget.destination
  //           },
  //         },
  //       );

  //       socket.connect();
  //       socket.on('connect', (_) {
  //         print('Connected');
  //       });

  //       socket.on('user_joined', (data) {
  //         var username = data['username'];

  //         setState(() {
  //           _users.add("$username joined room");
  //           Fluttertoast.showToast(msg: "$username joined room");
  //         });
  //       });

  //       socket.on('user_left', (data) {
  //         var username = data['username'];
  //         setState(() {
  //           _users.add("$username left room");
  //           Fluttertoast.showToast(msg: "$username left room");
  //         });
  //       });

  //       socket.on('message', (data) {
  //         print('Received: $data');
  //         print(cusername);
  //         print(data);
  //         setState(() {
  //           _messages.add("${data['username']}: ${data['message']}");
  //         });
  //       });

  //       socket.on('disconnect', (_) {
  //         print('Disconnected');
  //       });
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   socket.disconnect();
  //   super.dispose();
  // }

  // Future<void> fetchToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? storedToken = prefs.getString('token');
  //   setState(() {
  //     token = storedToken;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // body: SafeArea(
      //   top: true,
      //   child:
      body: Column(
        children: <Widget>[
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
                const SizedBox(height: 40),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => const Homescrn()));
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
                          Text(
                            'ChatRoom',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   width: 40,
                    // ),
                    // Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    //     child: IconButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => Reportscrn()));
                    //       },
                    //       icon: Icon(
                    //         Icons.report_gmailerrorred_outlined,
                    //         color: Colors.black,
                    //       ),
                    //     )),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       Navigator.pushReplacement(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (_) => const Homescrn()));
                    //     },
                    //     icon: Icon(
                    //       RickShare.disconnect_svgrepo_com,
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    // )
                    PopupMenuButton<String>(
                      iconColor: Colors.black,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>const Reportscrn()));
                          },
                          value: 'report',
                          child: const ListTile(
                            leading: Icon(RickShare.alert),
                            title: Text('Report'),
                          ),
                        ),
                        PopupMenuItem<String>(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Homescrn()));
                          },
                          value: 'disconnect',
                          child: const ListTile(
                            leading: Icon(
                              RickShare.disconnect_svgrepo_com,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Disconnect',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
              child: ListView.builder(
                controller: scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  String senderUsername = _messages[index].split(':')[0];
                  // Check if the message is sent by the current user
                  bool isCurrentUser =
                      _messages[index].startsWith(cusername ?? '');
                  bool sameSenderAsPrevious = index > 0 &&
                      _messages[index - 1].split(':')[0] == senderUsername;

                  return Padding(
                    padding: isCurrentUser
                        ? sameSenderAsPrevious
                            ? const EdgeInsets.fromLTRB(50.0, 2.0, 8.0, 2.0)
                            : const EdgeInsets.fromLTRB(50.0, 8.0, 8.0, 2.0)
                        : sameSenderAsPrevious
                            ? const EdgeInsets.fromLTRB(8.0, 2.0, 50.0, 2.0)
                            : const EdgeInsets.fromLTRB(8.0, 8.0, 50.0, 2.0),
                    child: Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isCurrentUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (sameSenderAsPrevious)
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: isCurrentUser
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                crossAxisAlignment: isCurrentUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _messages[index].split(':')[1],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: isCurrentUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isCurrentUser
                                      ? 'You'
                                      : _messages[index].split(':')[0],
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: isCurrentUser
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isCurrentUser
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _messages[index].split(':')[1],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          hintText: 'Message...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontFamily: 'Inter')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onPressed: _sendMessage,
                      tooltip: 'Send',
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class MyDialog extends StatefulWidget {
//   @override
//   _MyDialogState createState() => _MyDialogState();
// }

// class _MyDialogState extends State<MyDialog> {
//   bool isCheckboxChecked1 = false;
//   bool isCheckboxChecked2 = false;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Container(
//           width: 200.0,
//           height: 250.0, // Adjust the height as needed
//           padding: const EdgeInsets.all(20.0),

//           child: Column(
//             children: <Widget>[
//               const Text(
//                 'Report User',
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Inter'),
//               ),
//               const Text(
//                 "Select User to report:",
//                 style: TextStyle(fontFamily: 'Inter'),
//               ),
//               const SizedBox(height: 10.0),
//               ListTile(
//                 title: const Text(
//                   'User #',
//                   style: TextStyle(fontFamily: 'Inter'),
//                 ),
//                 leading: Checkbox(
//                     value: isCheckboxChecked1,
//                     onChanged: (value) {
//                       setState(() {
//                         isCheckboxChecked1 = value!;
//                       });
//                     }),
//               ),
//               ListTile(
//                 title: const Text(
//                   'User #',
//                   style: TextStyle(fontFamily: 'Inter'),
//                 ),
//                 leading: Checkbox(
//                     value: isCheckboxChecked2,
//                     onChanged: (value) {
//                       setState(() {
//                         isCheckboxChecked2 = value!;
//                       });
//                     }),
//               ),
//               const SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(fontFamily: 'Inter'),
//                     ),
//                   ),
//                   const SizedBox(width: 20.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (isCheckboxChecked1 || isCheckboxChecked2) {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => const Reportscrn()));
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text("Select user to report")));
//                       }
//                       //   Navigator.push(context, MaterialPageRoute(builder: (context) => Homescrn()),
//                       // );
//                     },
//                     child: const Text(
//                       'Next',
//                       style: TextStyle(fontFamily: 'Inter'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
