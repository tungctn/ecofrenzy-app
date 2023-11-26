import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/challenge.dart';
import 'constants.dart';
import 'dart:math';

List<Color> getGradientColor(Challenge challenge) {
  for (var i = 0; i < listProps.length; i++) {
    if (listProps[i]["category"] == challenge.category) {
      List<String>? hexColor = listProps[i]["color"] as List<String>?;
      List<Color> colors = [];
      for (var i = 0; i < hexColor!.length; i++) {
        hexColor[i] = hexColor[i].replaceAll("#", "");
        colors.add(Color(int.parse('FF${hexColor[i]}', radix: 16)));
      }
      return colors;
    }
  }
  return [];
}

Alignment getGradientRotate(num degree) {
  degree -= 90;
  final x = cos(degree * pi / 180);
  final y = sin(degree * pi / 180);
  final xAbs = x.abs();
  final yAbs = y.abs();

  if ((0.0 < xAbs && xAbs < 1.0) || (0.0 < yAbs && yAbs < 1.0)) {
    final magnification = (1 / xAbs) < (1 / yAbs) ? (1 / xAbs) : (1 / yAbs);
    return Alignment(x, y) * magnification;
  } else {
    return Alignment(x, y);
  }
}

Color getColorByCategory(String category) {
  for (var i = 0; i < listProps.length; i++) {
    if (listProps[i]["category"] == category) {
      List<String>? hexColor = listProps[i]["color"] as List<String>?;
      // hexColor[i] = hexColor[i].replaceAll("#", "");
      for (var i = 0; i < hexColor!.length; i++) {
        hexColor[i] = hexColor[i].replaceAll("#", "");
      }
      Color color = Color(int.parse('FF${hexColor[2]}', radix: 16));
      return color;
    }
  }
  return Color(int.parse('FF68D69D', radix: 16));
}
