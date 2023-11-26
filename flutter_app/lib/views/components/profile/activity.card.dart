import 'package:flutter/material.dart';
import 'package:flutter_app/utils/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityCard extends StatelessWidget {
  final String name;
  final String location;
  final int achieve;
  final String image_url;
  final String category;

  const ActivityCard({
    Key? key,
    required this.name,
    required this.location,
    required this.achieve,
    this.image_url =
        "https://s3-ap-southeast-1.amazonaws.com/social-media-image/kjswuzjmkxfh259dv9eztkelh17p",
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 352,
            height: 118.38,
            decoration: ShapeDecoration(
              color: getColorByCategory(category),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 137,
                            height: 51.05,
                            child: Text(
                              name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.locationDot,
                                        color: Colors.white, size: 16),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        location,
                                        softWrap: false,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.star,
                                        color: Colors.white, size: 16),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "Achieve: $achieve",
                                        softWrap: false,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      // height: 86.02,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image_url),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    )
                  ]),
            )),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
