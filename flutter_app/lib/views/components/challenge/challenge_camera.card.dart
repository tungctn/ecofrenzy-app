import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/models/challenge.dart';
import 'package:flutter_app/utils/color.dart';
import 'package:flutter_app/utils/icon.dart';

class ChallengeCameraCard extends StatefulWidget {
  final Challenge challenge;

  const ChallengeCameraCard({Key? key, required this.challenge})
      : super(key: key);

  @override
  ChallengeCameraCardState createState() => ChallengeCameraCardState();
}

class ChallengeCameraCardState extends State<ChallengeCameraCard> {
  Challenge get challenge => widget.challenge;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                            bottom: Radius.circular(15)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFBE61F8),
                            blurRadius: 20.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                        color: getGradientColor(challenge)[0],
                      ),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(getIcon(challenge)),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    challenge.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    // challenge.impact,
                                    "What is the impact of this challenge?",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      )),
                ),
              ]),
            ],
          )),
    );
  }
}
