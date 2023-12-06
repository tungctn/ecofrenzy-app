import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/provider/actions/challenge.action.dart';
import 'package:flutter_app/provider/notifiers/challenge.notifier.dart';
import 'package:flutter_app/views/components/challenge/challenge.card.dart';
import 'package:flutter_app/views/components/challenge/challenge.list.dart';
import 'package:flutter_app/utils/color.dart';
import 'package:flutter_app/views/components/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});
  @override
  ChallengeScreenState createState() => ChallengeScreenState();
}

class ChallengeScreenState extends State<ChallengeScreen> {
  bool _isLoading = false;
  bool isShowFriendChallenges = false;
  List<String> friendChallenges = ["Bike to Work", "DIY Totebag"];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadChallenges();
  }

  void loadChallenges() async {
    await ChallengeActions.fetchChallenges(context.read<ChallengeNotifier>());
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildFriendChallenges(notifier) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: friendChallenges.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.36000001430511475),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Liam" + " CHALLENGES you!!!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "“Hey, we should try this out. This challenge sounds fun ^^”",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      ChallengeCard(challenge: notifier.challenges[0])
                    ],
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeNotifier>(
      builder: (context, notifier, _) {
        if (_isLoading) {
          return const Loading();
        }
        return Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                margin: const EdgeInsets.only(
                    bottom: 20, top: 20, left: 10, right: 10),
                width: 380,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: -getGradientRotate(62.7),
                    end: getGradientRotate(62.7),
                    stops: const [
                      0.0686,
                      0.1614,
                      0.2541,
                      0.3469,
                      0.4396,
                      0.5324,
                      0.6251,
                      0.7179,
                      0.8106,
                      0.9034,
                      0.9961,
                      1.0889,
                      1.1816,
                      1.2744,
                      1.3671,
                      1.4599,
                      1.5526,
                    ],
                    colors: const [
                      Color(0xB343FE2E),
                      Color(0xB3A8E800),
                      Color(0xB3E0CF00),
                      Color(0xB3FFB300),
                      Color(0xB3FF9400),
                      Color(0xB3FF753A),
                      Color(0xB3FF5760),
                      Color(0xB3FF3B80),
                      Color(0xB3FF279D),
                      Color(0xB3FF22B6),
                      Color(0xB3FF2BCB),
                      Color(0xB3FF37DC),
                      Color(0xB3FF42EA),
                      Color(0xB3FF4AF3),
                      Color(0xB3F950FA),
                      Color(0xB3F453FE),
                      Color(0xB3F254FF),
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: const Text(
                            "Challenges from your friends",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF220A4F),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        !isShowFriendChallenges
                            ? TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorPalette.buttonColor)),
                                onPressed: () {
                                  setState(() {
                                    isShowFriendChallenges = true;
                                  });
                                },
                                child: const Text("HERE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900)),
                              )
                            : IconButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorPalette.buttonColor)),
                                onPressed: () {
                                  setState(() {
                                    isShowFriendChallenges = false;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.x,
                                  color: Colors.white,
                                  size: 12,
                                ))
                      ],
                    ),
                    isShowFriendChallenges
                        ? Container(
                            height: 320,
                            child: buildFriendChallenges(notifier),
                          )
                        : Container()
                  ],
                )),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0, // Đặt ràng buộc cho chiều rộng ở đây
                    top: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0, bottom: 0),
                      child: ChallengeList(
                        challenges: notifier.challenges,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
