// ignore_for_file: unnecessary_import, file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:rickshare/Views/Homescrn.dart';

class Pingscrn extends StatefulWidget {
  const Pingscrn({super.key});

  @override
  State<Pingscrn> createState() => _PingscrnState();
}

class _PingscrnState extends State<Pingscrn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Homescrn())));
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Center(
          child: Container(
            height: 275,
            width: 275,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(250, 193, 50, 1),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/lottie/Ping.json',
                        width: 250,
                      ),
                      Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
