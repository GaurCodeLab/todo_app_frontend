import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/models/todo_model.dart';

Future<void> scheduleReminder(ToDo task) async {
  final notifications = FlutterLocalNotificationsPlugin();
  await notifications.periodicallyShow(
      task.id,
      task.title,
      'Due date: ${task.dueDate}',
      RepeatInterval.daily,
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channelDescription',
      ),),);
}
