import 'dart:io';
import 'package:finance_app/core/res/AppImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/res/AppColor.dart';
import '../../core/res/AppStyle.dart';
import '../../core/widgets/WidgetText.dart';
import '../utils/Support.dart';

class WidgetSupport extends StatelessWidget {
  const WidgetSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget appBack(
    {required BuildContext context,
    required Color color,
    required VoidCallbackAction? Function() callbackAction}) {
  return IconButton(
    padding: const EdgeInsets.all(14),
    icon: Image.asset(AppImage.ic_app_icon, height: 40, width: 40),
    onPressed: () {
      callbackAction();
    },
  );
}

Widget showColorFiltered(String image, Color color) {
  return Container(
    width: 30,
    height: 30,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColor.colorPrimaryLight,
    ),
    padding: const EdgeInsets.all(7),
    child: Image.asset(image),
  );
}

VisualDensity zeroVisualDensity() {
  return const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity);
}

Container showCircularImage(
    {required BuildContext context,
    required double height,
    required double width,
    required bool border,
    required String placeholder,
    required String imageURL}) {
  return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(1),
      decoration: border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(width: 1, color: AppColor.colorPrimary),
              color: AppColor.colorWhite)
          : BoxDecoration(borderRadius: BorderRadius.circular(999)),
      child: ClipOval(
        child: imageURL == ""
            ? Image.asset(
                placeholder,
                fit: BoxFit.cover,
              )
            : FadeInImage.assetNetwork(
                placeholder: placeholder,
                image: formatImage(imageURL),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    placeholder,
                    fit: BoxFit.cover,
                  );
                }),
      ));
}

Widget showNetworkImage(imageURL, placeholder) {
  return imageURL == ""
      ? Image.asset(placeholder)
      : FadeInImage.assetNetwork(
          placeholder: placeholder,
          image: formatImage(imageURL),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              placeholder,
            );
          });
}

Container showCircularImageFromFile(
    {required BuildContext context,
    required double height,
    required double width,
    required bool border,
    required String placeholder,
    required String imageURL}) {
  return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(1),
      decoration: border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(width: 1, color: AppColor.colorPrimary),
              color: AppColor.colorWhite)
          : BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: ClipOval(
        child: Image.file(File(imageURL), fit: BoxFit.cover),
      ));
}

Widget uploadCamera(
    {required BuildContext context, required VoidCallback callback}) {
  return Material(
    color: AppColor.colorPrimary,
    borderRadius: BorderRadius.circular(50),
    child: InkWell(
      onTap: () {
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(AppImage.imgUploadCamera,
            height: 25,
            width: 25,
            colorFilter:
                const ColorFilter.mode(AppColor.colorWhite, BlendMode.srcIn)),
      ),
    ),
  );
}

Widget ttfLabel(String label) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.only(left: 5),
      child: appText(
          text: label,
          style: AppStyle.textAppStyle
              .copyWith(fontSize: 13, color: AppColor.colorTextLabel)),
    ),
    const SizedBox(height: 5),
  ]);
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
              image: formatImage(imageURL),
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  placeholder,
                  fit: BoxFit.cover,
                );
              }));
}

Container showSquareImageFromFile(
    {required BuildContext context,
    required double height,
    required double width,
    required bool border,
    required String imageURL}) {
  return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(0.5),
      decoration: border
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: AppColor.colorPrimary),
              color: AppColor.colorWhite)
          : BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Image.file(File(imageURL), fit: BoxFit.cover));
}

Widget loadImageFromInternet(
    {required BuildContext context,
    required String placeholder,
    required String imageURL}) {
  return FadeInImage.assetNetwork(
      placeholder: placeholder,
      image: formatImage(imageURL),
      fit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(placeholder);
      });
}

Widget multipleImageViewer(
    {required BuildContext context,
    required String placeholder,
    required String imageURL,
    required bool canDelete,
    required VoidCallback onViewImage,
    required VoidCallback onDeleteImage}) {
  return GestureDetector(
    onTap: () {
      onViewImage();
    },
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(formatImage(imageURL)), fit: BoxFit.cover),
        ),
        child: canDelete
            ? GestureDetector(
                onTap: () {
                  onDeleteImage();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColor.colorRed,
                      child: Icon(
                        Icons.clear,
                        size: 20,
                        color: AppColor.colorWhite,
                      )),
                ),
              )
            : Container()),
  );
}

formatPageHeader(String title) {
  return Container(
    width: double.maxFinite,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFF6D078),
          Color(0xFFFFB300),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            title.replaceAll("\n", ""),
            style: AppStyle.txtFieldHeader.copyWith(color: AppColor.colorBlack),
          ),
        ],
      ),
    ),
  );
}

formatListHeader(String title) {
  return Container(
    width: double.maxFinite,
    color: AppColor.headerBar,
    child: Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: AppStyle.txtFieldHeader,
          ),
        ],
      ),
    )),
  );
}
