import '../models/app_notification.dart';

class NotificationCenterService {
  static final List<AppNotification> _notifications = [];

  static List<AppNotification> get notifications =>
      List.unmodifiable(_notifications);

  static void add(AppNotification notification) {
    _notifications.insert(0, notification);
  }

  static void remove(String id) {
    _notifications.removeWhere(
      (notification) => notification.id == id,
    );
  }

  static void markAsRead(String id) {
    final index = _notifications.indexWhere(
      (notification) => notification.id == id,
    );

    if (index == -1) return;

    _notifications[index] =
        _notifications[index].copyWith(
      read: true,
    );
  }

  static void markAllAsRead() {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] =
          _notifications[i].copyWith(
        read: true,
      );
    }
  }

  static void clear() {
    _notifications.clear();
  }

  static int unreadCount() {
    return _notifications
        .where((notification) => !notification.read)
        .length;
  }
}