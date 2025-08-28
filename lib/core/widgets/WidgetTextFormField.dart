import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/AppColor.dart';
import '../res/AppStyle.dart';
import 'WidgetSupport.dart';

class WidgetTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType textInputType;
  final bool isEnabled;
  final bool isReadOnly;
  final String headerLabelText;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextStyle textStyle;
  final TextAlign? textAlign;
  final TextInputAction? action;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLine;
  final Function(String)? onChange;
  final Function()? onTap;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const WidgetTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      required this.inputFormatters,
      required this.textInputType,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.headerLabelText = "",
      this.labelText = "",
      this.hintText = "",
      this.isPassword = false,
      this.textStyle = AppStyle.textAppStyle,
      this.textAlign = TextAlign.start,
      this.floatingLabelBehavior = FloatingLabelBehavior.never,
      this.prefix,
      this.suffix,
      this.action,
      this.maxLine,
      this.onChange,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerLabelText != "") ...[ttfLabel(headerLabelText)],
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          enabled: isEnabled,
          controller: controller,
          readOnly: isReadOnly,
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          obscureText: isPassword,
          style: textStyle,
          onChanged: onChange,
          onTap: onTap,
          textInputAction: action,
          maxLines: maxLine,
          textAlign: textAlign!,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 70, right: 70, bottom: 30, top: 30),
            prefixIcon: prefix,
            suffixIcon: suffix,
            fillColor: isEnabled
                ? AppColor.colorTFFEnableBack
                : AppColor.colorTFFDisableBack,
            filled: true,
            // Enables the background color
            errorStyle: AppStyle.textStyleNormal
                .copyWith(fontSize: 12, color: AppColor.colorRed),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1.0),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colorPrimary, width: 1.0),
            ),
            floatingLabelBehavior: floatingLabelBehavior,
            floatingLabelStyle: AppStyle.textStyleNormal
                .copyWith(fontSize: 14, color: AppColor.colorPrimary),
            labelText: labelText,
            labelStyle: AppStyle.textStyleNormal
                .copyWith(fontSize: 14, color: AppColor.colorAppHint),
            hintText: hintText,
            hintStyle: AppStyle.textStyleNormal
                .copyWith(fontSize: 18, color: AppColor.colorAppHint),
          ),
        ),
      ],
    );
  }
}
