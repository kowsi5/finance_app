import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../res/AppColor.dart';
import '../res/AppStyle.dart';
import '../utils/Constants.dart';
import 'WidgetButton.dart';
import 'WidgetText.dart';

class WidgetPopup extends StatelessWidget {
  const WidgetPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void showProgress(BuildContext context) {
  var dialog = AlertDialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      content: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.colorGrayLightHigh),
                child: Lottie.asset("assets/json/loader.json",
                    width: 60, height: 60, repeat: true),
              ),
            ],
          );
        },
      ));

  if (!Constants.isProgressShowing) {
    showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
    Constants.isProgressShowing = true;
  }
}

void hideProgress(BuildContext context) {
  if (Constants.isProgressShowing) {
    Constants.isProgressShowing = false;
    Navigator.pop(context);
  }
}

void customSingleButtonPopup(
    {required BuildContext context,
    required String strTitle,
    required String strMessage,
    required String yesButtonName,
    required VoidCallback? Function(BuildContext context) okCallBack}) {
  var dialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      surfaceTintColor: AppColor.colorWhite,
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
                visible: strTitle != "",
                child: appText(
                    text: strTitle,
                    style: AppStyle.txtTitle,
                    textAlign: TextAlign.center)),
            if (strTitle != "")
              const SizedBox(
                height: 10,
              ),
            appText(
              text: strMessage,
              style: AppStyle.txtFieldValue,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            popupSuccessButton(
                context: context,
                strButtonName: yesButtonName,
                callback: () {
                  setState(() {
                    Navigator.pop(context);
                    okCallBack(context);
                  });
                  return null;
                })
          ],
        );
      }));

  showDialog(
    context: context,
    builder: (BuildContext context) => dialog,
    barrierDismissible: false,
  );
}

void customDoubleButtonPopup(
    {required BuildContext context,
    required String strTitle,
    required String strMessage,
    required String yesButtonName,
    required String noButtonName,
    required VoidCallback? Function(BuildContext context) yesCallBack,
    required VoidCallback? Function(BuildContext context) noCallBack}) {
  var dialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      surfaceTintColor: AppColor.colorWhite,
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
                visible: strTitle != "",
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    appText(
                        text: strTitle,
                        style: AppStyle.txtTitle,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                  ],
                )),
            appText(
                text: strMessage,
                style: AppStyle.txtFieldValue,
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: popupSuccessButton(
                      context: context,
                      strButtonName: yesButtonName,
                      callback: () {
                        setState(() {
                          Navigator.pop(context);
                          yesCallBack(context);
                        });
                        return null;
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: popupFailedButton(
                      context: context,
                      strButtonName: noButtonName,
                      callback: () {
                        setState(() {
                          Navigator.pop(context);
                          noCallBack(context);
                        });
                        return null;
                      }),
                )
              ],
            )
          ],
        );
      }));

  showDialog(
    context: context,
    builder: (BuildContext context) => dialog,
    barrierDismissible: false,
  );
}

void customAlertPopup(
    BuildContext context,
    String type,
    String strTitle,
    String strMessage,
    String yesButtonName,
    VoidCallback? Function(BuildContext context) okCallBack) {
  var lottie = "";
  if (type == Constants.lottieMaintenance) {
    lottie = 'assets/lottie/maintenance.json';
  }
  if (type == Constants.lottieSuccess) lottie = 'assets/json/success.json';
  if (type == Constants.lottieAlert) lottie = 'assets/lottie/alert.json';
  if (type == Constants.lottieError) lottie = 'assets/lottie/error.json';
  if (type == Constants.lottieNoInternet) {
    lottie = 'assets/lottie/no_internet.json';
  }

  var dialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      surfaceTintColor: AppColor.colorWhite,
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(lottie, width: 50, height: 50, repeat: false),
            Visibility(
                visible: strTitle != "",
                child: appText(
                    text: strTitle,
                    style: AppStyle.txtTitle,
                    textAlign: TextAlign.center)),
            if (strTitle != "")
              const SizedBox(
                height: 10,
              ),
            appText(
                text: strMessage,
                style: AppStyle.txtFieldValue,
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            popupSuccessButton(
                context: context,
                strButtonName: yesButtonName,
                callback: () {
                  setState(() {
                    Navigator.pop(context);
                    okCallBack(context);
                  });
                  return null;
                })
          ],
        );
      }));

  showDialog(
    context: context,
    builder: (BuildContext context) => dialog,
    barrierDismissible: false,
  );
}

void successSnackBar(
    {required BuildContext context, required String strMessage}) {
  final snackBar = SnackBar(
    content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          appText(
            text: strMessage,
            style: AppStyle.snackBarTextStyle,
          ),
          const Spacer(),
          Lottie.asset('assets/lottie/snack_success.json',
              width: 24, height: 24, repeat: false)
        ]),
    backgroundColor: AppColor.colorGreen,
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void failedSnackBar(
    {required BuildContext context, required String strMessage}) {
  final snackBar = SnackBar(
    content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          appText(
            text: strMessage,
            style: AppStyle.snackBarTextStyle,
          ),
          const Spacer(),
          Lottie.asset('assets/lottie/snack_failed.json',
              width: 24, height: 24, repeat: false)
        ]),
    backgroundColor: AppColor.colorRed,
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
