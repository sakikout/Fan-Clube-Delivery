import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/credit_card.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/push_notification_service.dart';
import 'package:intl/intl.dart';

class FirestoreService {

  User? user = FirebaseAuth.instance.currentUser;
  PushNotificationService notificationService = PushNotificationService();

  final CollectionReference foods = FirebaseFirestore.instance.collection('foods');
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  Future<void> addFoodsToDatabase(List<Food> foodList) async {
    for (Food food in foodList) {
      await foods.add(food.toMap());
    }

    print("Todos as comidas foram adicionadas!");
  }

  Future<List<Food>> getFoodsFromDatabase() async {
  try {
    QuerySnapshot querySnapshot = await foods.get();

    List<Food> foodList = querySnapshot.docs.map((doc) {
      return Food.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return foodList;
  } catch (e) {
    print("Erro ao buscar comidas no catálogo: $e");
    return [];
  }
}

  Future<String> saveOrderToDatabase(String receipt) async {
    DocumentReference orderRef = await orders.add({
      'user': user!.uid,
      'data': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
      'estimatedDeliveryTime': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now().add(Duration(minutes: 50 + 20))),
      'pedido': receipt,
      'status': "Recebendo pedido"
    });

    return orderRef.id;
  }

  Future<List<Map<String, dynamic>>> getUserOrders() async {
    QuerySnapshot querySnapshot = await orders
      .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy('data', descending: true)
      .get();

  return querySnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }

  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('orders')
      .doc(orderId)
      .get();

    if (!doc.exists) return null;

    return {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>,
    };
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await orders.doc(orderId).update({
      'status': newStatus,
    });

    DocumentSnapshot orderDoc = await orders.doc(orderId).get();
    String userId = orderDoc['user'];

    sendNotification(userId, "Confira a atualização no seu pedido!", "Agora seu pedido agora está $newStatus!");
    print("Status do pedido atualizado para: $newStatus");
  }

  Future<void> updateEstimatedDeliveryTime(String orderId, int time) async {
    await orders.doc(orderId).update({
      'estimatedDeliveryTime': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now().add(Duration(minutes: time))),
    });

    DocumentSnapshot orderDoc = await orders.doc(orderId).get();
    String userId = orderDoc['user'];

    sendNotification(userId, "Confira a atualização no seu pedido!", "Seu pedido irá demorar mais $time minutos para chegar.");
  }

  Future<void> sendNotification(String userId, String title, String message) async {
    DocumentSnapshot userDoc = await users.doc(userId).get();
    String? fcmToken = userDoc['fcmToken'];

    if (fcmToken != null) {
      await notificationService.sendPushNotificationFCM(fcmToken, title, message);
    }

    notificationService.showLocalNotification(title, message);
  }

  Future<void> saveUserToDatabase(String userId, AppUser userInfo) async {
    await users.doc(userId).set(userInfo.toMap());
  }

  Future<void> addCreditCardToDatabase(CreditCard newCard) async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
    DocumentReference userRef = users.doc(userId);

    try {
      DocumentSnapshot userDoc = await userRef.get();

      if (!userDoc.exists) {
        throw Exception("Usuário não encontrado!");
      }

      List<dynamic> existingCards = userDoc['creditCards'] ?? [];
      List<CreditCard> currentCards = existingCards.map((card) => 
                        CreditCard.fromMap(card)).toList();

      bool cardExists = currentCards.any((card) => 
                        card.cardNumber == newCard.cardNumber);

      if (cardExists) {
        print("Cartão já cadastrado!");
        return;
      }

      await userRef.update({
        'creditCards': FieldValue.arrayUnion([newCard.toMap()])
      });

      print("Cartão de crédito adicionado com sucesso!");
    } catch (e) {
      print("Erro ao adicionar cartão de crédito: $e");
    }
  }

  Future<List<CreditCard>> getUserCreditCards(String userId) async {
  DocumentSnapshot userDoc = await users
      .doc(userId)
      .get();

  if (!userDoc.exists) throw Exception("Usuário não encontrado!");

  List<dynamic> cardList = userDoc['creditCards'] ?? [];
  return cardList.map((card) => CreditCard.fromMap(card)).toList();
}

  Future<void> updateUserEmail(String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado.");
    }

    try {
      await user.updateEmail(newEmail);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'email': newEmail
      });

      print("E-mail atualizado com sucesso!");
    } catch (e) {
      throw Exception("Erro ao atualizar e-mail: $e");
    }
  }
  
  Future<void> updateUserPassword(String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado.");
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'password': newPassword
      });

      print("Senha atualizada com sucesso!");
    } catch (e) {
      throw Exception("Erro ao atualizar senha: $e");
    }
  }
  
  Future<void> updateUserAddress(String newAddress) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado.");
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'address': newAddress
      });
      print("Endereço atualizado com sucesso!");
    } catch (e) {
      throw Exception("Erro ao atualizar endereço: $e");
    }
  }

  Future<void> updateUserBirthday(String birthday) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado.");
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'birthday': birthday
      });
      print("Data de aniversário atualizada com sucesso!");
    } catch (e) {
      throw Exception("Erro ao atualizar data de aniversário: $e");
    }
  }

  Future<void> addNewAtribute(String atributeName, String value) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("Usuário não autenticado.");
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          atributeName: value
        }
      );

      print("Atributo adicionado com sucesso!");
    } catch (e) {
      throw Exception("Erro ao adicionar atributo: $e");
    }
  }

  Future<void> sendMessage(String receiverId, String message) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuário não autenticado.");

    String chatId = _getChatId(user.uid, receiverId);

    await chats.doc(chatId).collection('messages').add({
      'senderId': user.uid,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  String _getChatId(String user1, String user2) {
    List<String> ids = [user1, user2];
    ids.sort();
    return ids.join("_");
  }

  Stream<List<Map<String, dynamic>>> getMessages(String receiverId) {
    String chatId = _getChatId(FirebaseAuth.instance.currentUser!.uid, receiverId);

    return chats
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> deleteUserAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    DocumentReference userRef = users.doc(user.uid);

    try {
    await _deleteUserSubcollections(userRef);
    await userRef.delete();
    await user.delete(); // may cause an error, might fix later

    print("Conta deletada com sucesso!");
  } catch (e) {
    print("Erro ao deletar conta: $e");
  }
}

  Future<void> _deleteUserSubcollections(DocumentReference userRef) async {
    List<String> subcollections = ['notifications', 'orders'];

    for (String subcollection in subcollections) {
      QuerySnapshot snapshot = await userRef.collection(subcollection).get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }


}