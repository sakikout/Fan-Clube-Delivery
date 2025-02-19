import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';

class Receipt extends StatelessWidget {
  final FirestoreService db;
  final String orderId;
  const Receipt({super.key, required this.orderId, required this.db});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Obrigado pelo pedido!"),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),     
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(25),
              child: FutureBuilder<Map<String, dynamic>?>(
                      future: db.getOrderById(orderId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                        if (!snapshot.hasData || snapshot.data == null) {
                            return Center(child: Text("Pedido não encontrado."));
                          }

                        var order = snapshot.data!;

                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text("Pedido #${order['id']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text("Data: ${order['data']}"),
                              Text("Pedido: ${order['pedido']}"),
                              Text("Status: ${order['status']}"),
                          ],
            ),
          );
        },
      ),



            ),

            const SizedBox(height: 25),
            Text("Tempo estimado para o delivery: "),
          ],
        ),
      ),
    );
  }
}