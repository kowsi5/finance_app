import 'package:finance_app/core/res/AppColor.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const TextStyle whithe16w700 = TextStyle(
      color: AppColor.colorWhite, fontWeight: FontWeight.w700, fontSize: 16);
  static const TextStyle whithe14w700 = TextStyle(
      color: AppColor.colorWhite, fontWeight: FontWeight.w700, fontSize: 14);
  static const TextStyle whithe14 =
      TextStyle(color: AppColor.colorWhite, fontSize: 14);

  static const TextStyle textStyleExtraBold =
      TextStyle(fontFamily: 'Bamini,Sans-serif', fontWeight: FontWeight.w800);

  static const TextStyle textStyleBold =
      TextStyle(fontFamily: 'Bamini,Sans-serif', fontWeight: FontWeight.bold);

  static const TextStyle textStyleSemiBold = TextStyle(
      fontFamily: 'Bamini,Sans-serif',
      fontWeight: FontWeight.w600,
      color: AppColor.colorTextDark);

  static const TextStyle textStyleMedium =
      TextStyle(fontFamily: 'Bamini,Sans-serif', fontWeight: FontWeight.w500);

  static const TextStyle textStyleNormal =
      TextStyle(fontFamily: 'Bamini,Sans-serif', fontWeight: FontWeight.w400);

  static const TextStyle textStyleLight =
      TextStyle(fontFamily: 'Bamini,Sans-serif', fontWeight: FontWeight.w300);

  static TextStyle prPurple15 = AppStyle.whithe14.copyWith(
      fontSize: 15, fontWeight: FontWeight.bold, color: AppColor.prPurple);

  static TextStyle colorBlack12 =
      AppStyle.whithe14w700.copyWith(fontSize: 12, color: AppColor.colorBlack);

  static TextStyle geryColor15 = AppStyle.whithe14w700.copyWith(
      fontSize: 13, color: AppColor.silverText, fontWeight: FontWeight.normal);

  static TextStyle labelStyle = const TextStyle(
      fontSize: 13,
      color: AppColor.colorTextMedium,
      fontFamily: 'Bamini,Sans-serif',
      fontWeight: FontWeight.w400);

  static TextStyle valueStyle = const TextStyle(
      fontSize: 15,
      color: AppColor.colorTextDark,
      fontFamily: 'Bamini,Sans-serif',
      fontWeight: FontWeight.w600);

  static TextStyle blackbold12 = AppStyle.whithe14w700.copyWith(
      fontSize: 12,
      color: AppColor.colorBlack,
      fontWeight: FontWeight.bold,
      fontFamily: 'Bamini,Sans-serif');

  static TextStyle white17600 = AppStyle.whithe14w700.copyWith(
      fontSize: 17,
      color: AppColor.colorWhite,
      fontWeight: FontWeight.w600,
      fontFamily: 'Bamini,Sans-serif');

  static TextStyle black17600 = AppStyle.whithe14w700.copyWith(
      fontSize: 17,
      color: AppColor.colorBlack,
      fontWeight: FontWeight.w600,
      fontFamily: 'Bamini,Sans-serif');

  static const TextStyle textAppStyle =
      TextStyle(fontFamily: 'Bamini,Sans-serif', fontWeight: FontWeight.normal);

  static const TextStyle snackBarTextStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Bamini,Sans-serif',
      fontWeight: FontWeight.w600,
      color: AppColor.colorWhite);

  static const TextStyle txtHeader = TextStyle(
      fontFamily: 'Bamini,Sans-serif',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.colorBlack);

  static const TextStyle txtTitle = TextStyle(
      fontFamily: 'Bamini,Sans-serif',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColor.colorBlack);

  static const TextStyle txtSubTitle = TextStyle(
      fontFamily: 'Bamini,Sans-serif',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.colorBlack);

  static const TextStyle txtFieldHeader = TextStyle(
      fontFamily: 'Bamini,Sans-serif',
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: AppColor.colorBlack);

  static const TextStyle txtFieldValue = TextStyle(
      fontFamily: 'Bamini,Sans-serif',
      fontSize: 12.5,
      fontWeight: FontWeight.w500,
      color: AppColor.colorBlack);

  static BoxDecoration cardDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: AppColor.colorWhite,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(
            1.0,
            1.0,
          ),
          blurRadius: 0.5,
          spreadRadius: 0.0,
        )
      ]);

  static InputDecoration textFieldDecoration = const InputDecoration(
    labelText: '',
    hintText: '',
    labelStyle: TextStyle(fontSize: 13, color: Colors.black),
    hintStyle: TextStyle(fontSize: 13, color: AppColor.colorGray),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black38, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.colorPrimary, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
  );

  static InputDecoration dropdownDecoration = InputDecoration(
    contentPadding:
        const EdgeInsets.only(left: 10, right: 10, bottom: 12, top: 0),
    fillColor: AppColor.colorTrans,
    filled: true,
    errorStyle: AppStyle.textStyleNormal
        .copyWith(fontSize: 11, color: AppColor.colorRed),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black38, width: 1),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black38, width: 1 // No border when not focused
          ),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black38, width: 1 // No border when not focused
          ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColor.colorPrimary, width: 1 // No border when not focused
          ),
    ),
    floatingLabelStyle: AppStyle.textStyleNormal
        .copyWith(fontSize: 14, color: AppColor.colorPrimary),
    labelText: "Select ",
    labelStyle: AppStyle.textStyleNormal
        .copyWith(fontSize: 14, color: AppColor.colorAppHint),
    hintText: "Select ",
    hintStyle: AppStyle.textStyleNormal
        .copyWith(fontSize: 14, color: AppColor.colorAppHint),
  );
}
