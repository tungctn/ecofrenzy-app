import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final String rank;
  final String name;
  final int points;
  final bool isYou;
  final Color color;
  final double height;

  const PlayerCard({
    Key? key,
    required this.rank,
    required this.name,
    required this.points,
    this.isYou = false,
    this.color = Colors.purple,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(8.0),

        child: Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF4A2198),
              child: Image.asset(
                'assets/images/avatar.png',
                width: 70,
                height: 70,
              ),
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xff68d69d),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                points.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Ridley Grotesk Bold'),
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff68d69d),
                  fontWeight: FontWeight.w900,
                  fontFamily: "Ridley Grotesk Bold"),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(0),
          width: 105,
          height: height,
          decoration: BoxDecoration(
            color: color,
            // borderRadius: BorderRadius.only(
            //   topLeft: const Radius.circular(20),
            //   topRight: const Radius.circular(20),
            // )),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (rank.isNotEmpty)
                Positioned(
                  top: 40,
                  bottom: 40,
                  child: Text(rank,
                      style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'Ridley Grotesk ExtraBold',
                          fontWeight: FontWeight.bold)),
                ),
              if (isYou)
                const Positioned(
                  right: 10,
                  top: 10,
                  child: Icon(Icons.star, color: Colors.yellow),
                ),
            ],
          ),
        )
      ],
    ));
  }
}
