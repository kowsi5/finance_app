import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../res/AppColor.dart';
import '../res/AppStyle.dart';
import 'WidgetText.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget fullScreenLoader() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.colorGrayLightHigh),
        child: Lottie.asset("assets/json/loader.json",
            width: 60, height: 60, repeat: true),
      ),
    ],
  ));
}

Widget primaryButton(
    {required BuildContext context,
    required String strButtonName,
    required VoidCallback? Function() callback}) {
  return Material(
    color: AppColor.appprimary,
    borderRadius: BorderRadius.circular(5),
    child: InkWell(
      splashColor: AppColor.appprimary,
      child: Container(
        width: double.maxFinite,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.appprimary, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: appText(
          text: strButtonName,
          textAlign: TextAlign.center,
          style: AppStyle.textStyleSemiBold
              .copyWith(fontSize: 20, color: AppColor.colorWhite),
        ),
      ),
      onTap: () {
        callback();
      },
    ),
  );
}

Widget greenSubmitButton(
    {required BuildContext context,
    required String strButtonName,
    required VoidCallback? Function() callback}) {
  return Material(
    color: AppColor.colorSubmitButton,
    borderRadius: BorderRadius.circular(5),
    child: InkWell(
      splashColor: AppColor.colorSubmitButton,
      child: Container(
        width: double.maxFinite,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.colorSubmitButton, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: appText(
          text: strButtonName,
          textAlign: TextAlign.center,
          style: AppStyle.txtFieldHeader
              .copyWith(fontSize: 13, color: AppColor.colorWhite),
        ),
      ),
      onTap: () {
        callback();
      },
    ),
  );
}

Widget popupSuccessButton(
    {required BuildContext context,
    required String strButtonName,
    required VoidCallback? Function() callback}) {
  return Material(
    color: AppColor.appprimary,
    borderRadius: BorderRadius.circular(5),
    child: InkWell(
      splashColor: AppColor.appprimary,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColor.appprimary.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: appText(
          text: strButtonName,
          textAlign: TextAlign.center,
          style: AppStyle.txtFieldHeader
              .copyWith(fontSize: 13, color: AppColor.colorWhite),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        callback();
      },
    ),
  );
}

Widget popupFailedButton(
    {required BuildContext context,
    required String strButtonName,
    required VoidCallback? Function() callback}) {
  return Material(
    child: InkWell(
      splashColor: AppColor.colorGray,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColor.colorGray.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: appText(
          text: strButtonName,
          textAlign: TextAlign.center,
          style: AppStyle.txtFieldHeader
              .copyWith(fontSize: 13, color: AppColor.colorBlack),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        callback();
      },
    ),
  );
}

Widget popupactiveButton(
    {required BuildContext context,
    required String strButtonName,
    required VoidCallback? Function() callback}) {
  return Material(
    color: AppColor.greenColor10,
    borderRadius: BorderRadius.circular(5),
    child: InkWell(
      splashColor: AppColor.greenColor10,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColor.appprimary.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: appText(
          text: strButtonName,
          textAlign: TextAlign.center,
          style: AppStyle.txtFieldHeader
              .copyWith(fontSize: 13, color: AppColor.colorWhite),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        callback();
      },
    ),
  );
}

Widget popupcolsedButton(
    {required BuildContext context,
    required String strButtonName,
    required VoidCallback? Function() callback}) {
  return Material(
    color: AppColor.colorRed,
    borderRadius: BorderRadius.circular(5),
    child: InkWell(
      splashColor: AppColor.colorRed,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColor.appprimary.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: appText(
          text: strButtonName,
          textAlign: TextAlign.center,
          style: AppStyle.txtFieldHeader
              .copyWith(fontSize: 13, color: AppColor.colorWhite),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        callback();
      },
    ),
  );
}
