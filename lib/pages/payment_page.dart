import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_button.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';
import 'package:flutter_application_1/components/my_drawer_tile.dart';
import 'package:flutter_application_1/models/credit_card.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:flutter_application_1/pages/delivery_progress_page.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  FirestoreService db = FirestoreService();
  String? _selectedPaymentMethod;
  final TextEditingController _cashController = TextEditingController();
  String? _selectedCard;
  bool _isPaymentConfirmed = false;
  List<CreditCard> _creditCards = [];

  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
      _isPaymentConfirmed = false;
    });
  }

  Future<void> _loadCreditCards() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _creditCards = db.getUserCreditCards(user.uid) as List<CreditCard>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Forma de Pagamento"),
      ),

      body: Column(
        children: [
          const Spacer(),

           MyDrawerTile(
            text: "Cartão de Crédito no Aplicativo", 
            icon: Icons.credit_card, 
            onTap: () {
              Navigator.pop(context);
              context.read<Restaurant>().updatePaymentMethod("Cartão de Crédito no Aplicativo");
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const DeliveryProgressPage()));
            }),

          const SizedBox(height: 25,),

            MyDrawerTile(
            text: "Cartão na Entrega", 
            icon: Icons.delivery_dining, 
            onTap: () {
              Navigator.pop(context);
              context.read<Restaurant>().updatePaymentMethod("Cartão na Entrega");
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const DeliveryProgressPage()));
            }),

          const SizedBox(height: 25,),

            MyDrawerTile(
            text: "Dinheiro na Entrega", 
            icon: Icons.monetization_on_outlined, 
            onTap: () {
              Navigator.pop(context);
              context.read<Restaurant>().updatePaymentMethod("Dinheiro na Entrega");
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const DeliveryProgressPage()));
            }),

          const SizedBox(height: 25,),

            MyDrawerTile(
            text: "Pix", 
            icon: Icons.monetization_on_outlined, 
            onTap: () {
              Navigator.pop(context);
              context.read<Restaurant>().updatePaymentMethod("Pix");
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const DeliveryProgressPage()));
            }),

            if (_selectedPaymentMethod != null)
              _buildPaymentOptions(),

            const SizedBox(height: 25),

            CustomButton(
            onTap: _isPaymentConfirmed ?
                    () {
                      Navigator.pop(context);
                      String receipt = context.read<Restaurant>().receiptToDatabase();
                      Future<String> orderId = db.saveOrderToDatabase(receipt);
                      context.read<Restaurant>().updateCurrentOrder(orderId);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryProgressPage()));
                    }
              : null, 
            text: "Pague agora"),


          const SizedBox(height: 25,),

        ],
      ),
    );
  }

   Widget _buildPaymentOptions() {
    switch (_selectedPaymentMethod) {
      case "Cartão de Crédito no Aplicativo":
        return _buildCreditCardSelection();
      case "Dinheiro na Entrega":
        return _buildCashInput();
      case "Pix":
        return _buildPixQRCode();
      default:
        return const SizedBox();
    }
  }

  Widget _buildCreditCardSelection() {
    if (_creditCards.isEmpty) {
      return const Text("Nenhum cartão cadastrado.", style: TextStyle(fontWeight: FontWeight.bold));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Selecione um cartão salvo:", 
        style: TextStyle(fontWeight: FontWeight.bold)),
        
        ..._creditCards.map((card) => RadioListTile(
              title: Text("${card.cardIdentification} **** ${card.cardNumber.substring(card.cardNumber.length - 4)}"),
              value: card.cardNumber,
              groupValue: _selectedCard,
              onChanged: (value) {
                setState(() {
                  _selectedCard = value;
                  _isPaymentConfirmed = true;
                });
              },
            )),
      ],
    );
  }

  Widget _buildCashInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Informe o troco necessário:", 
        style: TextStyle(fontWeight: FontWeight.bold)),
        CustomTextfield(
          controller: _cashController,
          hintText: "Ex: 50.00",
          obscureText: false,
          onChanged: (value) => setState(
            () => _isPaymentConfirmed = value.isNotEmpty
          ),
        ),
      ],
    );
  }

  Widget _buildPixQRCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Escaneie o QR Code ou copie o código Pix abaixo:", 
                    style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          color: Colors.grey[300],
          height: 150,
          width: 150,
          child: const Center(child: Icon(Icons.qr_code, size: 100, color: Colors.black54)),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() => _isPaymentConfirmed = true);
          },
          child: const Text("Copiar Código Pix", 
                            style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}

