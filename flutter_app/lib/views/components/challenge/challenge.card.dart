import 'package:flutter/material.dart';
import 'package:flutter_app/models/challenge.dart';
import 'package:flutter_app/provider/actions/challenge.action.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:provider/provider.dart';
import 'challenge.detail.dart';
import 'package:flutter_app/utils/icon.dart';
import 'package:flutter_app/utils/color.dart';

class ChallengeCard extends StatefulWidget {
  final Challenge challenge;

  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  @override
  ChallengeCardState createState() => ChallengeCardState();
}

class ChallengeCardState extends State<ChallengeCard> {
  Challenge get challenge => widget.challenge;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool isPicked = challenge.status == "UnPicked";
    double opacity = isPicked ? 0.4 : 1.0;
    return Opacity(
        opacity: opacity,
        child: IgnorePointer(
          ignoring: isPicked,
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 20, top: 20),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
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
                                      radius: 32,
                                      child: Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image:
                                                AssetImage(getIcon(challenge)),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          challenge.name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                "Ridley Grotesk ExtraBold",
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          challenge.caption,
                                          // "What is the impact of this challenge?",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 20),
                                if (isExpanded)
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: 2,
                                          width: 320,
                                          child:
                                              Container(color: Colors.white)),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ChallengeDetail(
                                                challenge: challenge),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ],
                            )),
                      ),
                    ]),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(15),
                              ),
                              color: getGradientColor(challenge)[2],
                            ),
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.centerRight,
                            child: isExpanded
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          icon: cancelIcon,
                                          label: const Text(""),
                                        ),
                                      ),
                                      Expanded(
                                          child: FittedBox(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            ChallengeActions.pickChallenge(
                                                context
                                                    .read<ChallengeNotifier>(),
                                                challenge.id);
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          icon: likeIcon,
                                          label: const Text(""),
                                        ),
                                      )),
                                      Expanded(
                                        child: TextButton.icon(
                                          onPressed: () {},
                                          icon: shareIcon,
                                          label: const Text(""),
                                        ),
                                      ),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: const Text(
                                      "View More >>>     ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Ridley Grotesk SemiBold",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }
}
