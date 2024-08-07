import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/models/todo_model.dart';

class NotificationHandler {
  final FlutterLocalNotificationsPlugin _notifications;

  NotificationHandler(this._notifications);

  Future<void> showNotification(ToDo task) async {
    await _notifications.show(
        task.id,
        task.title,
        'Due date: ${task.dueDate}',
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'channelDescription',
        )));
  }
}
