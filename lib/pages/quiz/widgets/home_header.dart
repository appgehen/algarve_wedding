import 'package:flutter/material.dart';
import 'package:algarve_wedding/widgets/neon-sign/neon.dart';

Widget getHomeHeader(context) {
  return SliverAppBar(
    backgroundColor: Colors.black,
    expandedHeight: 250.0,
    stretch: true,
    stretchTriggerOffset: 150.0,
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: [
        StretchMode.blurBackground,
        StretchMode.zoomBackground,
        StretchMode.fadeTitle,
      ],
      background: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'images/wall.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withAlpha(125),
                            blurRadius: 45,
                            spreadRadius: 25,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Neon(
                          text: 'Quiz',
                          color: Colors.purple,
                          fontSize: 80,
                          font: NeonFont.Neon,
                          flickeringText: false,
                          flickeringLetters: null,
                          glowingDuration: new Duration(seconds: 1),
                        ),
                        Neon(
                          text: 'Time',
                          color: Colors.blue,
                          fontSize: 80,
                          font: NeonFont.Neon,
                          flickeringText: true,
                          flickeringLetters: [3],
                          glowingDuration: new Duration(seconds: 2),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
