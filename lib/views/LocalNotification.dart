import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocalNotificationState();
  }
}

class _LocalNotificationState extends State<LocalNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var initSetting = new InitializationSettings(android: android, iOS: ios);

    flutterLocalNotificationPlugin.initialize(initSetting,
        onSelectNotification: SelectNotification);
  }

  Future SelectNotification(String payload) {
    print("Hello");
  }

  void showNotification() {
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        priority: Priority.high);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(
      android: android,iOS: ios
    );
    flutterLocalNotificationPlugin.show(0, "Iacom", "Hello",platform,payload:"SendMessage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
          child: Column(children: <Widget>[
           RaisedButton(child:
            new Text("show Notification"),
               onPressed: () {showNotification();})
      ])),
    );
  }
}
