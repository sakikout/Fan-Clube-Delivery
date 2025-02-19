import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    NotificationSettings settings = await _fcm.requestPermission();
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permissão concedida!");

      String? token = await _fcm.getToken();
      print("Token do dispositivo: $token");

      if (token != null) {
        await saveTokenToDatabase(token);
      }

    } else {
      print("Não autorizado.");
    }

  }

  Future<void> saveTokenToDatabase(String token) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'fcmToken': token,
    });
  }

  Future<void> sendPushNotificationFCM(String token, String title, String message) async {
  const String serverKey = " "; //firebase key i couldn't get yet
  const String fcmUrl = "https://fcm.googleapis.com/fcm/send";

  try {
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode({
        'to': token,
        'notification': {
          'title': title,
          'body': message,
        },
      }),
    );

    print("Resposta do FCM: ${response.body}");
  } catch (e) {
    print("Erro ao enviar notificação: $e");
  }
}

  Future<void> showAllNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'all_notifications',
      'Notificações',
      importance: Importance.max,
      priority: Priority.defaultPriority,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
    
    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );

     await saveNotificationToDatabase(title, body);

}

  Future<void> showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'user_notifications',
      'Notificações',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
    
    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );

     await saveNotificationToDatabase(title, body);

}

  Future<void> saveNotificationToDatabase(String title, String body) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return; 
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    await userRef.collection('notifications').add({
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteAllNotifications() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    try {
      QuerySnapshot snapshot = await userRef.collection('notifications').get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print("Todas as notificações foram deletadas!");
    } catch (e) {
      print("Erro ao deletar notificações: $e");
    }
  }

  Future<void> deleteNotificationById(String notificationId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return; 

    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    try {
      await userRef.collection('notifications').doc(notificationId).delete();
        print("Notificação deletada com sucesso!");
    } catch (e) {
        print("Erro ao deletar notificação: $e");
    }
}


}
