// Web-compatible notification service
class NotificationService {
  static Future<void> initialize() async {
    // Web initialization - simplified
    print('NotificationService initialized for web');
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // For web, we'll just log the notification
    print('Scheduled notification: $title - $body at $scheduledTime');
  }

  static Future<void> cancelNotification(int id) async {
    print('Cancelled notification with id: $id');
  }
}