import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_button.dart';
import 'package:flutter_application_1/components/receipt.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:flutter_application_1/pages/deliveries_page.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryDetailsPage extends StatelessWidget {
  final String orderId;
  final FirestoreService database;

  const DeliveryDetailsPage({
    super.key, 
    required this.orderId, 
    required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Pedido"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Receipt(orderId:orderId, db:database),

          if (Provider.of<Restaurant>(context, listen: false).currentOrder == orderId)
              CustomButton(
                  onTap: () {
                      Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeliveryHistoryPage(),
                          ),
                      );
                    },
                  text: "Ver Status do Pedido",
              ),

          const SizedBox(height: 25),


        ],
      ),
    );
  }

}
