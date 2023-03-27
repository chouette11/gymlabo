import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';

Future<void> foregroundNotification(RemoteMessage message) async {
  print("フォアグラウンドでメッセージを受け取りました");

  RemoteNotification? notification = message.notification;

  /// iosの設定
  const initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  const initializationSettings = InitializationSettings(
    iOS: initializationSettingsDarwin,
  );

  /// flutterの設定
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  if (notification != null) {
    /// androidの設定
    final channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        iOS: const DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: "ic_notification",
          color: ColorConstant.purple40,
        ),
      ),
    );
  }
}
