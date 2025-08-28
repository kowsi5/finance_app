import 'package:flutter/material.dart';

import '../res/AppStyle.dart';

class WidgetText extends StatelessWidget {
  const WidgetText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget appText(
    {text = "",
      textAlign = TextAlign.start,
      style = AppStyle.textStyleNormal,
      maxLines = 1000,
      overflow = TextOverflow.ellipsis}) {
  return Text(text,
      textAlign: textAlign,
      style: style,
      maxLines: maxLines,
      overflow: overflow);
}

Widget appTextWithImage(
    {text = "",
      textAlign = TextAlign.start,
      style = AppStyle.textStyleNormal,
      maxLines = 1000,
      overflow = TextOverflow.ellipsis,
      Widget? prefix,
      Widget? suffix}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (prefix != null) prefix,
      Text(text,
          textAlign: textAlign,
          style: style,
          maxLines: maxLines,
          overflow: overflow),
      if (suffix != null) suffix,
    ],
  );
}
