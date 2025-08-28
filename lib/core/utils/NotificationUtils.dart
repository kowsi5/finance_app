import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI {
  NotificationAPI._internal();

  static NotificationAPI get instance => NotificationAPI._internal();

  /// Initialize notification variables
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Show notification
  showNotification(
      {required String title,
        required String body,
        Importance? notificationImportance,
        String? payload}) async {
    NotificationDetails noti = _getNotificationDetails(false, null, null, null);
    await _flutterLocalNotificationsPlugin.show(
      2,
      title,
      body,
      noti,
      payload: payload,
    );
  }

  /// Show notification
  showImageNotification(
      {required String title,
        required String body,
        String? payload,
        required String imagePath}) async {
    Uint8List bytes =
    (await NetworkAssetBundle(Uri.parse(imagePath)).load(imagePath))
        .buffer
        .asUint8List();
    NotificationDetails noti = _getNotificationDetails(true, bytes, null, null);
    await _flutterLocalNotificationsPlugin.show(
      2,
      title,
      body,
      noti,
      payload: payload,
    );
  }

  /// Auto-Generated notification details
  NotificationDetails _getNotificationDetails(
      bool isShowBigPicture,
      Uint8List? image,
      Importance? notificationImportance,
      Priority? priority) {
    AndroidNotificationDetails androidNoti = AndroidNotificationDetails(
      "Basic",
      "Basic Notifications",
      icon: "@drawable/ic_notifications_icon",
      largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
      channelShowBadge: true,
      importance: Importance.max,
      priority: Priority.high,
      color: const Color(0xFFE65100),
      playSound: true,
      styleInformation: isShowBigPicture
          ? BigPictureStyleInformation(
        ByteArrayAndroidBitmap(
          image!,
        ),
      )
          : null,
    );
    DarwinNotificationDetails iosNoti = const DarwinNotificationDetails(
      presentSound: true,
    );
    return NotificationDetails(
      android: androidNoti,
      iOS: iosNoti,
    );
  }

  /// Stop all the notifications
  stopAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Stop particular notifications with id
  stopNotification({required int id}) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
