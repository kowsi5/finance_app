import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String DatePattern1 = "dd-MM-yyyy hh:mm a";
  static String DatePattern2 = "yyyy-MM-dd HH:mm:ss";
  static String DatePattern3 = "yyyy-MM-dd hh:mm:ss a";
  static String DatePattern4 = "yyyy-MM-dd'T'HH:mm:ss.SSSz";
  static String DatePattern5 = "EEE, MMM dd yyyy hh:mm a";
  static String DatePattern6 = "EEE, MMM dd yyyy";
  static String DatePattern7 = "dd.MM.yyyy";
  static String DatePattern8 = "dd/MM/yyyy";
  static String DatePattern9 = "dd-MM-yyyy";
  static String DatePattern10 = "yyyy-MM-dd";
  static String DatePattern11 = "hh:mm a";
  static String DatePattern12 = " HH:mm:ss";
  static String DatePattern13 = "MMM yyyy";
  static String DatePattern14 = "yyyy";
  static String DatePattern15 = "dd/MM/yyyy";
  static String DatePattern16 = "dd MMM yyyy";
  static String DatePattern17 = "MMM-yy";
  static String DatePattern18 = "MMMM yyyy";
  static String DatePattern19 = "ddMMyy";
  static String DatePattern20 = "yyyyMMdd";
  static String DatePattern21 = "MMM-yyyy";

  static getCurrentUTCTime(String pattern) {
    return DateFormat(pattern).format(DateTime.now().toUtc());
  }

  static getCurrentTime(String pattern) {
    return DateFormat(pattern).format(DateTime.now());
  }

  static getAdd1Date(String inputDate) {
    if (inputDate == "") {
      return "";
    }
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);

    DateTime newDate = tempDate.add(const Duration(days: 1));
    return DateFormat(AppDateUtils.DatePattern10).format(newDate);
  }

  static getSub1Date(String inputDate) {
    if (inputDate == "") {
      return "";
    }
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);

    DateTime newDate = tempDate.add(const Duration(days: -1));
    return DateFormat(AppDateUtils.DatePattern10).format(newDate);
  }

  static formatDateTimeFromString(String inputDate, String pattern) {
    if (inputDate == "") {
      return "";
    }
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);
    return DateFormat(pattern).format(tempDate);
  }

  static formatDateFromString(String inputDate, String pattern) {
    if (inputDate == "") {
      return "";
    }
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);
    return DateFormat(pattern).format(tempDate);
  }

  static convertTo24HourFormat(String time12Hour) {
    try {
      // Parse the input 12-hour time
      DateTime dateTime = DateFormat("hh:mm a").parse(time12Hour);

      // Format as 24-hour time
      return DateFormat("HH:mm:ss").format(dateTime);
    } catch (e) {
      return "Invalid time format";
    }
  }

  static formatTimeFromString(String inputDate, String pattern) {
    if (inputDate == "") {
      return "";
    }
    inputDate = "2021-12-12 $inputDate";
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);
    return DateFormat(pattern).format(tempDate);
  }

  static convertLocalToUTC(String inputDate, String pattern) {
    if (inputDate == "") {
      return "";
    }
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);
    return DateFormat(pattern).format(tempDate.toUtc());
  }

  static convertUTCToLocal(String inputDate, String pattern) {
    if (inputDate == "") {
      return "";
    }
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    DateTime tempDate = DateTime.parse(inputDate);
    tempDate = DateTime.utc(tempDate.year, tempDate.month, tempDate.day,
        tempDate.hour, tempDate.minute, tempDate.second);
    return DateFormat(pattern).format(tempDate.toLocal());
  }

  static subtractDate(String maxInputDate, String minInputDate) {
    maxInputDate = maxInputDate.replaceAll(".000Z", "").replaceAll("T", " ");
    minInputDate = minInputDate.replaceAll(".000Z", "").replaceAll("T", " ");

    DateTime maxDate = DateTime.parse(maxInputDate);
    DateTime minDate = DateTime.parse(minInputDate);

    Duration duration = maxDate.difference(minDate);
    return duration.inSeconds;
  }

  static formatPostDate(String inputDate) {
    String result = "";
    inputDate = inputDate.replaceAll(".000Z", "").replaceAll("T", " ");

    DateTime currentUTCTime = DateTime.now().toUtc();
    print(currentUTCTime);
    DateTime tempDate = DateTime.parse(inputDate);
    DateTime currentInputDate = DateTime.utc(tempDate.year, tempDate.month,
        tempDate.day, tempDate.hour, tempDate.minute, tempDate.second);
    print(currentInputDate);

    Duration duration = currentUTCTime.difference(currentInputDate);

    int diffSeconds = duration.inSeconds;
    int diffMinutes = diffSeconds ~/ 60;
    int diffHours = diffSeconds ~/ (60 * 60);
    int diffDays = diffSeconds ~/ (24 * 60 * 60);

    if (diffDays >= 2) {
      result = "at " + convertUTCToLocal(inputDate, "MMM dd yyyy, hh:mm a");
    } else if (diffDays >= 1) {
      result = "1 day ago";
    } else if (diffHours >= 2) {
      result = "$diffHours hours ago";
    } else if (diffHours >= 1) {
      result = "$diffHours hour ago";
    } else if (diffMinutes >= 2) {
      result = "$diffMinutes mins ago";
    } else if (diffMinutes >= 1) {
      result = "$diffMinutes min ago";
    } else {
      result = "now";
    }

    return result;
  }

  static checkDateStatus(String dateString) {
    // Parse the string into a DateTime object
    DateTime givenDate = DateTime.parse(dateString);
    // Get the current date
    DateTime today = DateTime.now();

    // Reset the time part of the DateTime objects to only compare the date
    today = DateTime(today.year, today.month, today.day);
    givenDate = DateTime(givenDate.year, givenDate.month, givenDate.day);

    // Compare the dates
    if (givenDate.isBefore(today)) {
      return "Past";
    } else if (givenDate.isAfter(today)) {
      return "Future";
    } else {
      return "Today";
    }
  }
}
