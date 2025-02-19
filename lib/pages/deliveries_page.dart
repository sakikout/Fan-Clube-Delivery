import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/delivery_details_page.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';

class DeliveryHistoryPage extends StatefulWidget {
  const DeliveryHistoryPage({super.key});

  @override
  State<DeliveryHistoryPage> createState() => _DeliveryHistoryPageState();
}

class _DeliveryHistoryPageState extends State<DeliveryHistoryPage> {
  FirestoreService db = FirestoreService();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery"),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
            future: db.getUserOrders(),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Nenhum pedido encontrado. :("));
                }

              List<Map<String, dynamic>> orders = snapshot.data!;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index];
                  return ListTile(
                    title: Text("Pedido #${order['id']}"),
                    subtitle: Text("Status: ${order['status']}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryDetailsPage(orderId: order['id'], database:db,),
                        ),
                      );
                    },
                  );
               },
              );
            },
        ),
     
    );
  }

}
