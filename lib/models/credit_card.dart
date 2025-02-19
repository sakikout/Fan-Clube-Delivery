class CreditCard {
  final String cardIdentification;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;

  CreditCard({
    required this.cardIdentification, 
    required this.cardNumber, 
    required this.expiryDate, 
    required this.cardHolderName, 
    required this.cvvCode, 
  });
  
  // convert a CreditCard to a map (to save to firebase)

  Map<String, dynamic> toMap() {
    return {
      'cardIdentification': cardIdentification,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expirationDate': expiryDate,
      'cvv': cvvCode,
    };
  }

    // convert a firebase map back to a CreditCard object

   factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      cardIdentification: map['cardIdentification'],
      cardNumber: map['cardNumber'],
      cardHolderName: map['cardHolder'],
      expiryDate: map['expiryDate'], 
      cvvCode: map['cvvCode'],
    );
  }

}