import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';
import 'package:flutter_app/models/challenge.dart';

Widget cancelIcon = SvgPicture.asset('assets/icons/cancel.svg');
Widget likeIcon = SvgPicture.asset('assets/icons/like.svg');
Widget shareIcon = SvgPicture.asset('assets/icons/share.svg');
Widget feedIcon = SvgPicture.asset('assets/icons/feed.svg');
Widget incentivesIcon = SvgPicture.asset('assets/icons/incentives.svg');
Widget leaderboardIcon = SvgPicture.asset('assets/icons/leaderboard.svg');
Widget learnIcon = SvgPicture.asset('assets/icons/learn.svg');
Widget feedIconSelect = SvgPicture.asset('assets/icons/feed.select.svg');
Widget incentivesIconSelect =
    SvgPicture.asset('assets/icons/incentives.select.svg');
Widget leaderboardIconSelect =
    SvgPicture.asset('assets/icons/leaderboard.select.svg');
Widget learnIconSelect = SvgPicture.asset('assets/icons/learn.select.svg');
Widget backIcon = SvgPicture.asset('assets/icons/back.svg');
Widget cameraAltIcon = SvgPicture.asset('assets/icons/camera_alt.svg');
Widget tymIcon = SvgPicture.asset('assets/icons/tym.svg');
Widget commentIcon = SvgPicture.asset('assets/icons/comment.svg');

String getIcon(dynamic challenge) {
  for (var i = 0; i < listProps.length; i++) {
    if (listProps[i]["category"] == challenge.category) {
      return listProps[i]["icon"] as String;
    }
  }
  return "assets/images/consumption.png";
}

String getIconByCategory(String category) {
  for (var i = 0; i < listProps.length; i++) {
    if (listProps[i]["category"] == category) {
      return listProps[i]["icon"] as String;
    }
  }
  return "assets/images/consumption.png";
}
