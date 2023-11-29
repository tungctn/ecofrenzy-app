import 'package:flutter/material.dart';
import 'package:flutter_app/views/components/leaderboard/player.card.dart';
import 'package:flutter_app/views/components/leaderboard/your.card.dart';

class LeaderBoardScreen extends StatefulWidget {
  static const String routeName = '/leaderboard';

  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  LeaderBoardScreenState createState() => LeaderBoardScreenState();
}

class LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final points = [
    2500,
    2000,
    1500,
  ];
  final yourPoints = 500;
  final heightInit = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightGreenAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          // Bọc bằng SingleChildScrollView
          child: Container(
            // margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [Color(0xFF5F2AC5), Color(0xFF4A2198)],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Text("TOP 3 PLAYERS",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xff5F2AC5),
                        fontWeight: FontWeight.w900,
                        fontFamily: "Ridley Grotesk Bold",
                      )),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PlayerCard(
                              rank: '02',
                              name: 'STUART',
                              points: points[1],
                              color: const Color(0xFF08BB70),
                              height: heightInit * points[1] / points[0]),
                          PlayerCard(
                              rank: '01',
                              name: 'YOU',
                              points: points[0],
                              // isYou: true,
                              color: const Color(0xFF1AE16A),
                              height: heightInit * 1.0),
                          PlayerCard(
                              rank: '03',
                              name: 'JORDAN',
                              points: points[2],
                              color: const Color(0xFF65EDA4),
                              height: heightInit * points[2] / points[0]),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 50),
                    const YourCard(
                      point: 500,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
