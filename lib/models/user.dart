import 'package:flutter_application_1/models/credit_card.dart';

class AppUser {
  String firstName;
  String lastName;
  String email;
  String password;
  DateTime createdAt;
  List<CreditCard> creditCards;
  String address;
  final Map<String, dynamic> _additionalAttributes = {};

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.creditCards,
    required this.address,
  });


  void setAttribute(String key, dynamic value) {
    _additionalAttributes[key] = value;
  }

  dynamic getAttribute(String key) {
    return _additionalAttributes[key];
  }

  Map<String, dynamic> get additionalAttributes => _additionalAttributes;
  Map<String, dynamic> toMapAtributes() => _additionalAttributes;

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'creditCards': creditCards.map((card) => card.toMap()).toList(),
      'address': address,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      createdAt: DateTime.parse(map['createdAt']),
      creditCards: (map['creditCards'] as List<dynamic>?)
              ?.map((card) => CreditCard.fromMap(card))
              .toList() ??
          [],
      address: map['address']
    );
  }
}
