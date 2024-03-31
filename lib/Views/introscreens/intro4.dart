// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class intro4 extends StatelessWidget {
  const intro4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 229, 0, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Happy RickSharing!",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Lottie.asset(
                  'assets/lottie/rickshaw.json',
                  width: 200,
                  height: 200,
                ),
              )),
            ],
          ),
          // Text(
          //       "Decide a location to meet",
          //       style: TextStyle(
          //         fontFamily: 'Inter',
          //         fontWeight: FontWeight.bold,
          //         fontSize: 22,
          //         color: Color.fromARGB(255, 0, 0, 0),

          //       ),
          //       overflow: TextOverflow.clip,
          //       softWrap: true,
          //     ),
        ],
      ),
    );
  }
}
