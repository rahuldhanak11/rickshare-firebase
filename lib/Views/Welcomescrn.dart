// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rickshare/Views/Homescrn.dart';
import 'package:rickshare/Views/introscreens/intro1.dart';
import 'package:rickshare/Views/introscreens/intro2.dart';
import 'package:rickshare/Views/introscreens/intro3.dart';
import 'package:rickshare/Views/introscreens/intro4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcomescrn extends StatefulWidget {
  const Welcomescrn({super.key});

  @override
  State<Welcomescrn> createState() => _WelcomescrnState();
}

class _WelcomescrnState extends State<Welcomescrn> {
  final PageController _controller = PageController();

  //track of last page
  bool onlastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onlastpage = (index == 3);
              });
            },
            children: const [
              Intro1(),
              Intro2(),
              Intro3(),
              intro4(),
            ],
          ),
          //dot indicators
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                onlastpage
                    ? const SizedBox(
                        width: 5,
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Homescrn()));
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),

                //dot indicators
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                ),

                //next or done
                onlastpage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Homescrn()));
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
