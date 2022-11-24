import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../class/Habit.dart';
import '../class/HabitPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _width = 100;

  void change_screen(String screenName) {
    setState(() {
      _width = 250;
    });
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, screenName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff131b26),
      body: InkWell(
        onTap: () => change_screen('/habitPage'),
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                top: 180,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Habit Tracker',
                    style: TextStyle(
                      fontSize: mediaQuery.width / 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 250,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedContainer(
                      duration: const Duration(
                        seconds: 2,
                      ),
                      curve: Curves.fastOutSlowIn,
                      height: 2,
                      width: _width,
                      color: Colors.deepPurple,
                    )),
              ),
              Positioned.fill(
                top: 400,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText(
                                "Press anywhere to start",
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            pause: const Duration(milliseconds: 50),
                            repeatForever: true,
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          )
                          //  Text(
                          //   "Press anywhere to start",
                          //   style: TextStyle(color: Colors.grey, fontSize: 16),
                          //   textAlign: TextAlign.center,
                          // ),
                          ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
