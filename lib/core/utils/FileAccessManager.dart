import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../res/AppColor.dart';
import '../res/AppImage.dart';
import '../res/AppStyle.dart';
import '../widgets/WidgetText.dart';

class FileAccessManager {
  FileAccessManager._();
}

Future<String?> accessImagePicker({required context}) async {
  final res = await showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.colorLightBlack,
    builder: (BuildContext context) {
      final ImagePicker picker = ImagePicker();
      return Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 16.0, bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.colorGrayDark,
              ),
            )),
            const SizedBox(
              height: 15,
            ),
            appText(
              text: "Choose image picker",
              style: AppStyle.textStyleMedium
                  .copyWith(color: AppColor.colorWhite, fontSize: 14),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop(image!.path.toString());
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppImage.imgPickerCamera,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      appText(
                        text: "Camera",
                        style: AppStyle.textStyleNormal
                            .copyWith(color: AppColor.colorWhite, fontSize: 11),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(image!.path.toString());
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        AppImage.imgPickerGallery,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      appText(
                        text: "Gallery",
                        style: AppStyle.textStyleNormal
                            .copyWith(color: AppColor.colorWhite, fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
  if (res != null) {
    return Future.value(res);
  } else {
    return null;
  }
}
Future<CroppedFile?> cropImage({
  required context,
  required imageFile,
  quality = 90,
}) async {
  ImageCompressFormat format = ImageCompressFormat.jpg;
  if (imageFile.toString().endsWith("png")) {
    format = ImageCompressFormat.png;
  }
  return await ImageCropper().cropImage(
    sourcePath: imageFile,
    compressFormat: format,
    compressQuality: quality,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        statusBarColor: AppColor.colorPrimaryDark,
        toolbarColor: AppColor.colorWhite,
        toolbarWidgetColor: AppColor.colorPrimary,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      IOSUiSettings(
        title: 'Cropper',
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      ),
      WebUiSettings(
        context: context,
        presentStyle: WebPresentStyle.dialog,
        size: const CropperSize(
          width: 520,
          height: 520,
        ),
      ),
    ],
  );
}