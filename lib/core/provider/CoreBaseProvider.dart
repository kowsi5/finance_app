// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';



class CoreBaseProvider extends ChangeNotifier {
  bool isAPILoading = true;
  String filePath = "";
  String errorMessage = "";

  CoreBaseProvider(context, screen) {
    errorMessage = "";
    // Connectivity().checkConnectivity().then((value) {
    //   if (value == ConnectivityResult.none) {
    //     networkDiableSnackBar(
    //         context: context, strMessage: "You are in offline mode");
    //   }
    // });
  }



  updateFilePath(String path) {
    filePath = path;
    notifyListeners();
  }

  // Intro Screen //
  int introCurrentScreen = 0;
  bool isAgree = false;

  updateIntroCurrentScreen(int screen) {
    introCurrentScreen = screen;
    notifyListeners();
  }

  updateIsAgree(bool value) {
    isAgree = value;
    notifyListeners();
  }

  // CMS Screen
  String content = "";

  updateCMSContent(String value) {
    content = value;
    notifyListeners();
  }

  bool isShowPassword = false;
  bool isShowNewPassword = false;
  bool isShowConfirmPassword = false;

  updateShowHidePassword(bool value) {
    isShowPassword = value;
    notifyListeners();
  }

  updateShowHideNewPassword(bool value) {
    isShowNewPassword = value;
    notifyListeners();
  }

  updateShowHideConfirmPassword(bool value) {
    isShowConfirmPassword = value;
    notifyListeners();
  }

}
