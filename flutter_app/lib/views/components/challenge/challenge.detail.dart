import 'package:flutter/material.dart';
import 'package:flutter_app/models/challenge.dart';

class ChallengeDetail extends StatelessWidget {
  final Challenge challenge;

  const ChallengeDetail({Key? key, required this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arr = [
      "Commit to bringing your own reusable bags when shopping instead of using single-use plastic bags.",
      "Make a conscious effort to avoid unnecessary plastic waste."
    ];
    final imgs = [
      "assets/images/6.png",
      "assets/images/15.png",
      "assets/images/6.png",
    ];
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cách thực hiện?",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Ridley Grotesk ExtraBold",
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Column(
            children: challenge.implemetation
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: const Icon(
                            Icons.circle,
                            size: 4,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: imgs
                  .map((e) => ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(50)), // Định nghĩa BorderRadius
                      child: Image.asset(
                        e,
                        height: 180,
                        width: 140,
                      )))
                  .toList(),
            ),
          ),
          
        ],
      ),
    );
  }
}
