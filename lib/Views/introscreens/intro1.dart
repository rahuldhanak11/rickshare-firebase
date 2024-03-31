import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 229, 0, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose your Start and Destination",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              // Text(
              //   "Your Source will be the station you want to catch an Auto from",
              //   style: TextStyle(
              //     fontFamily: 'Inter',
              //     fontWeight: FontWeight.bold,
              //     fontSize: 15,
              //     color: Color.fromRGBO(0, 0, 0, 1),
              //   ),
              //   overflow: TextOverflow.clip,
              //   softWrap: true,
              // ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Image.asset(
                  'assets/images/src-01.png',
                  alignment: const Alignment(0.5, 0.5),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
