import 'package:flutter/material.dart';
import 'Support.dart';

class AppNavigator {
  AppNavigator._();
}

navigatePushAndRemoveUntil(context, screen) {
  hideKeyboard(context);
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => screen), (r) {
    return false;
  });
}

navigatePushReplacement(context, screen) {
  hideKeyboard(context);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

navigatePush(context, screen) {
  hideKeyboard(context);
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

Future navigatePushCallBack(context, screen) {
  hideKeyboard(context);
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

navigatePop(context) {
  Navigator.pop(context);
}

navigatePopCallBack(context, value) {
  Navigator.pop(context, value);
}
