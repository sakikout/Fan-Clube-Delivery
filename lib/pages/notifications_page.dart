import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';
import 'package:flutter_application_1/services/push_notification_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  FirestoreService db = FirestoreService();
  PushNotificationService notificationService = PushNotificationService();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Notificações"),
      ),
        body: Column( children: [Center(child: Text("Erro ao carregar as notificações. Tente entrar novamente."))]),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Notificações"),
         actions: [
              // clear notifications button
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text("Tem certeza que quer apagar as notificações?"),
                      actions: [
                        // cancel button
                        TextButton(
                          onPressed: (){ Navigator.pop(context);}, 
                          child: const Text("Cancelar")),

                        // confirm button
                          TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                            notificationService.deleteAllNotifications();
                          }, 
                          child: const Text("Confirmar")),

                      ],
                    )
                    );
                }, 
                icon: const Icon(Icons.delete))
            ]
      ),

      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('notifications')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Nenhuma notificação encontrada."));
                }

                return ListView(
                        children: snapshot.data!.docs.map((doc) {
                            return ListTile(
                                    title: Text(doc['title']),
                                    subtitle: Text(doc['body']),
                                    trailing: Text(
                                        (doc['timestamp'] as Timestamp).toDate().toString(),
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                  );
                                }).toList(),
                       );
                  },
                ),
          ]
      )
    );
  }
}