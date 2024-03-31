// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:rickshare/Views/Loginscrn.dart';
import 'package:video_player/video_player.dart';

class Splashscrn extends StatefulWidget {
  const Splashscrn({super.key});

  @override
  State<Splashscrn> createState() => _SplashscrnState();
}

class _SplashscrnState extends State<Splashscrn> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 2800),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Loginscrn(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
              child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,300,0,0),
              child: Container(
                // child: Lottie.asset('assets/lottie/splash8.json'),
                child: Image.asset('assets/images/logo.png',
                height: 80,
                ),
              ),
            ),
          )),
          Expanded(
            child: Center(
                        child: Container(
            child: Container(
              // color: Color.fromRGBO(255, 153, 0, 1),
              child: Image.asset('assets/images/khshadow-01.png',
              height: 350,
              ),
            ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
