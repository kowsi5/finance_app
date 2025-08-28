import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:finance_app/core/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../../core/res/AppImage.dart';
import '../res/AppColor.dart';
import 'AppDateUtils.dart';

class Support {
  Support._();
}

getMapAPIKey() {
  if (Platform.isAndroid) {
    return "AIzaSyAQE8CRGBvY6tKSTa9WblcPUWFlHOj6L8E";
  } else if (Platform.isIOS) {
    return "AIzaSyAQE8CRGBvY6tKSTa9WblcPUWFlHOj6L8E";
  }
}

Future<bool> isInternetAvailable() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (e) {
    // Handle any exceptions, likely no internet
    print('Error checking internet: $e');
  }
  return false;
}

formatImage(String image) {
  if (image == "") {
    return "";
  } else if (image.startsWith("http")) {
    return image;
  } else {
    // return APIConfig.baseImageURL + image;
  }
}

convertToDouble(String? value) {
  if (value == null || value == "") {
    return 0.0;
  } else {
    return double.parse(value);
  }
}

convertToInteger(String? value) {
  if (value == null || value == "") {
    return 0;
  } else {
    return int.parse(value);
  }
}

toast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.colorToastBackground,
      textColor: AppColor.colorToastText,
      fontSize: 16.0);
}

hideKeyboard(context) {
  FocusScope.of(context).unfocus();
}

formatResponseData(String data) {
  if (data == "null") {
    return "";
  } else {
    return data;
  }
}

Future<String> readAssetFiles(
    {required BuildContext context, required String file}) async {
  return await DefaultAssetBundle.of(context).loadString(file);
}

formatNeramTime(String? data) {
  return (data == null || data == ""
      ? '-'
      : data.replaceAll(RegExp(r'AM|PM'), '').trim());
}

getEnglishDayFromTamil(String tmDay) {
  if (tmDay == "ஞாயிற்றுக்கிழமை" || tmDay == "ஞாயிறு") {
    return "Sun";
  } else if (tmDay == "திங்கட்கிழமை" || tmDay == "திங்கள்") {
    return "Mon";
  } else if (tmDay == "செவ்வாய்") {
    return "Tue";
  } else if (tmDay == "புதன்") {
    return "Wed";
  } else if (tmDay == "வியாழன்") {
    return "Thu";
  } else if (tmDay == "வெள்ளி") {
    return "Fri";
  } else if (tmDay == "சனிக்கிழமை" || tmDay == "சனி") {
    return "Sat";
  } else {
    return "";
  }
}

getMonthNumber(String monthname) {
  if (monthname == "jan" || monthname == "Jan" || monthname == "January") {
    return "01";
  } else if (monthname == "feb" ||
      monthname == "Feb" ||
      monthname == "February") {
    return "02";
  } else if (monthname == "mar" || monthname == "Mar" || monthname == "March") {
    return "03";
  } else if (monthname == "apr" || monthname == "Apr" || monthname == "April") {
    return "04";
  } else if (monthname == "may" || monthname == "May" || monthname == "May") {
    return "05";
  } else if (monthname == "jun" || monthname == "Jun" || monthname == "June") {
    return "06";
  } else if (monthname == "jul" || monthname == "Jul" || monthname == "July") {
    return "07";
  } else if (monthname == "aug" ||
      monthname == "Aug" ||
      monthname == "August") {
    return "08";
  } else if (monthname == "sep" ||
      monthname == "Sep" ||
      monthname == "September") {
    return "09";
  } else if (monthname == "oct" ||
      monthname == "Oct" ||
      monthname == "October") {
    return "10";
  } else if (monthname == "nov" ||
      monthname == "Nov" ||
      monthname == "November") {
    return "11";
  } else if (monthname == "dec" ||
      monthname == "Dec" ||
      monthname == "December") {
    return "12";
  } else {
    return "01";
  }
}

String formatWithLeadingZero(String number) {
  return number.padLeft(2, '0');
}

Container showSquareImage(
    {required BuildContext context,
    required double height,
    required double width,
    required bool border,
    required String placeholder,
    required String imageURL}) {
  return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(0.5),
      decoration: border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: AppColor.colorPrimary),
              color: AppColor.colorWhite)
          : BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: imageURL == ""
          ? Image.asset(
              placeholder,
              fit: BoxFit.cover,
            )
          : FadeInImage.assetNetwork(
              placeholder: placeholder,
              image: imageURL,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  placeholder,
                  fit: BoxFit.cover,
                );
              }));
}

Container showSquareImageNonFit(
    {required BuildContext context,
    required double height,
    required double width,
    required bool border,
    required String placeholder,
    required String imageURL}) {
  return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(0.5),
      decoration: border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: AppColor.colorPrimary),
              color: AppColor.colorWhite)
          : BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: imageURL == ""
          ? Image.asset(placeholder)
          : FadeInImage.assetNetwork(
              placeholder: placeholder,
              image: imageURL,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(placeholder);
              }));
}

getEventOutlineDecoration(String type) {
  if (type == "Past") {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.colorGrayLightHigh);
  } else if (type == "Future") {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: AppColor.colorWhite);
  } else if (type == "Today") {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.headerBar),
        color: AppColor.colorWhite);
  }
}

getEventDateDecoration(String type) {
  if (type == "Past") {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.colorGrayLight,
        border: Border.all(color: AppColor.colorGrayLight));
  } else if (type == "Future") {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.colorTitleGreen,
        border: Border.all(color: AppColor.colorTitleGreen));
  } else if (type == "Today") {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.headerBar,
        border: Border.all(color: AppColor.headerBar));
  }
}

getEventTimeColor(String type) {
  if (type == "Past") {
    return AppColor.colorGray;
  } else if (type == "Future") {
    return AppColor.pinkColors;
  } else if (type == "Today") {
    return AppColor.headerBar;
  }
}

Future<bool> assetExists(String assetPath) async {
  try {
    await rootBundle.load(assetPath);
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> launchInBrowser(Uri url) async {
  try {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  } catch (error) {
    print("Error");
  }
}

vibrate() {
  Vibration.vibrate();
}

getHeaderBorderColor(String month, String year) {
  String currentMonth = AppDateUtils.getCurrentTime("MMM");
  String currentYear = AppDateUtils.getCurrentTime("yyyy");

  if (month.toLowerCase() == currentMonth.toLowerCase() &&
      year == currentYear) {
    return AppColor.headerBar;
  } else {
    return AppColor.colorExpandHeader;
  }
}

getHeaderLabelColor(String month, String year) {
  String currentMonth = AppDateUtils.getCurrentTime("MMM");
  String currentYear = AppDateUtils.getCurrentTime("yyyy");

  if (month.toLowerCase() == currentMonth.toLowerCase() &&
      year == currentYear) {
    return AppColor.colorBlack;
  } else {
    return AppColor.colorWhite;
  }
}

Future<void> launchURL(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

getServicePlaceHolderImage(String type) {
  if (type == Constants.serviceTypeJosiyar) {
    return AppImage.imgService2;
  } else if (type == Constants.serviceTypeManaiyadiSasthiram) {
    return AppImage.imgService5;
  } else if (type == Constants.serviceTypeIyer) {
    return AppImage.imgService2;
  } else if (type == Constants.serviceTypeKurukal) {
    return AppImage.imgService2;
  }
}

Future<String> getDeviceId() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceId = "";

  if (kIsWeb) {
    final webBrowserInfo = await deviceInfo.webBrowserInfo;
    deviceId =
        '${webBrowserInfo.vendor ?? '-'} + ${webBrowserInfo.userAgent ?? '-'} + ${webBrowserInfo.hardwareConcurrency.toString()}';
  } else if (Platform.isAndroid) {
    const androidId = AndroidId();
    deviceId = await androidId.getId();
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.identifierForVendor!;
  } else if (Platform.isLinux) {
    final linuxInfo = await deviceInfo.linuxInfo;
    deviceId = linuxInfo.machineId!;
  } else if (Platform.isWindows) {
    final windowsInfo = await deviceInfo.windowsInfo;
    deviceId = windowsInfo.deviceId;
  } else if (Platform.isMacOS) {
    final macOsInfo = await deviceInfo.macOsInfo;
    deviceId = macOsInfo.systemGUID!;
  }

  return deviceId ?? "";
}
