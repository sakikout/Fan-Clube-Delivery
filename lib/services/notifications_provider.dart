import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;

  bool get notificationsEnabled => _notificationsEnabled;

  NotificationProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications') ?? true;
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', _notificationsEnabled);

    if (_notificationsEnabled) {
      print("Notificações ativadas");
       await FirebaseMessaging.instance.subscribeToTopic("all_notifications");
    } else {
      print("Notificações desativadas");
      await FirebaseMessaging.instance.unsubscribeFromTopic("all_notifications");
    }

    notifyListeners();
  }
}
