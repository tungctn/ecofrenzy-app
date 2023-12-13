import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HelpUtils {
  static String formatNumberToK(int number) {
    if (number >= 1000) {
      double result = number / 1000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
    } else {
      return number.toString();
    }
  }

  static String formatNumberToVND(int number) {
    String numberStr = number.toString();
    String numberStrConvert = "";

    int count = 1;
    for (int i = numberStr.length - 1; i >= 0; i--) {
      if (count == 3 && i != 0) {
        count = 1;
        numberStrConvert = "," + numberStr[i] + numberStrConvert;
      } else {
        count++;
        numberStrConvert = numberStr[i] + numberStrConvert;
      }
    }

    return numberStrConvert + "đ";
  }

  static String formatTimestamp(int timestamp, String timeZone, String format) {
    initializeDateFormatting(); // Initialize date formatting for intl library
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat(format);

    // Apply time zone offset
    var timeZoneOffset = DateTime.now().timeZoneOffset;
    dateTime = dateTime.add(timeZoneOffset);

    return formatter.format(dateTime);
  }

  static String CalExpDateFromNowWithSecond(int expDate) {
    if (expDate < 1e12) {
      expDate = expDate * 1000;
    }

    String formattedDate = formatTimestamp(expDate, "Asia/Bangkok", "dd/MM");
    return formattedDate;
  }
}
