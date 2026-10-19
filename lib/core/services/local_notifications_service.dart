import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'emenu_orders',
    'Emenu Orders',
    description: 'Order notifications',
    importance: Importance.high,
  );

  AndroidFlutterLocalNotificationsPlugin? get _android => _notifications
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  /// Must be called once in every isolate that shows notifications
  /// (the main isolate AND the FCM background isolate).
  Future<void> init() async {
    if (_isInitialized) return;

    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _notifications.initialize(settings: settings);
    await _android?.createNotificationChannel(_channel);

    _isInitialized = true;
  }

  /// Android 13+ (API 33) blocks notifications until the user grants
  /// POST_NOTIFICATIONS at runtime. Needs an Activity, so call it from the
  /// main isolate only — never from the background handler.
  Future<bool> requestPermission() async
  => await _android?.requestNotificationsPermission() ?? true;

  Future<void> show({
    required int id,
    required String? title,
    required String? body,
  }) async {
    await init();
    await _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}