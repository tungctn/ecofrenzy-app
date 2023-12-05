import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
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
  bool isShare = false;
  List<String> friends = [
    "The Anh",
    "Tung",
    "Ngoc",
    "Ruou",
    "Tao",
    "Meo",
    "Ngon"
  ];
  List<String> friendsSelected = [];

  Widget buildListFriend() {
    return ListView(
      children: List.generate(
          friends.length,
          (index) => Container(
                height: 52,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn.sforum.vn/sforum/wp-content/uploads/2023/08/hinh-nen-meo-9.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          friends[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Checkbox(
                          value: friendsSelected.contains(friends[index]),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                friendsSelected.add(friends[index]);
                              } else {
                                friendsSelected.remove(friends[index]);
                              }
                            });
                          })
                    ]),
              )),
    );
  }

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
                            padding: const EdgeInsets.only(top: 20),
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
                                if (isExpanded && !isShare)
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
                                else if (isExpanded && isShare)
                                  Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 14),
                                                decoration: BoxDecoration(
                                                  color: getGradientColor(
                                                      challenge)[2],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 32,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.white,
                                                      ),
                                                      child: TextField(
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        decoration: InputDecoration(
                                                            hintText: 'Search',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6000000238418579))),
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 320,
                                                        child:
                                                            buildListFriend())
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: 2,
                                          width: double.infinity,
                                          child:
                                              Container(color: Colors.white)),
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
                                ? (isShare
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red)),
                                              onPressed: () {
                                                setState(() {
                                                  isShare = false;
                                                });
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          ColorPalette
                                                              .buttonColor)),
                                              onPressed: () {
                                                setState(() {
                                                  isShare = false;
                                                });
                                              },
                                              child: const Text("Challenge",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  isExpanded = !isExpanded;
                                                  isShare = false;
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
                                                    context.read<
                                                        ChallengeNotifier>(),
                                                    challenge.id);
                                                setState(() {
                                                  isExpanded = true;
                                                });
                                              },
                                              icon: likeIcon,
                                              label: const Text(""),
                                            ),
                                          )),
                                          Expanded(
                                            child: TextButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  isShare = true;
                                                });
                                              },
                                              icon: shareIcon,
                                              label: const Text(""),
                                            ),
                                          ),
                                        ],
                                      ))
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
