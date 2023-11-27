import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TypeToast { warning, error, success, info }

class ToastUtils {
  static void showToast(BuildContext context, String message, TypeToast type) {
    Color textColor = Colors.white;
    Color backgroundColor = ColorPalette.primaryColor;
    IconData iconToast = FontAwesomeIcons.check;

    switch (type) {
      case TypeToast.warning:
        backgroundColor = Colors.orange;
        iconToast = FontAwesomeIcons.triangleExclamation;
        break;
      case TypeToast.error:
        backgroundColor = Colors.red;
        iconToast = FontAwesomeIcons.xmark;
        break;
      case TypeToast.success:
        backgroundColor = Colors.green;
        iconToast = FontAwesomeIcons.check;
        break;
      case TypeToast.info:
        backgroundColor = ColorPalette.primaryColor;
        iconToast = FontAwesomeIcons.exclamation;
        break;
    }

    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            iconToast,
            color: textColor,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
