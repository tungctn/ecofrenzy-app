import 'package:flutter/material.dart';

class YourCard extends StatelessWidget {
  final int point;
  const YourCard({
    Key? key,
    required this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF1AE16A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: const BoxDecoration(
              color: Color(0xFF4A2198),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Container cho hình ảnh
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "You",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$point PT",
                style: const TextStyle(
                    fontFamily: "Ridley Grotesk Bold",
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4A2198)),
              ))
        ],
      ),
    );
  }
}
