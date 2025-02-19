import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/receipt.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:flutter_application_1/pages/chat_restaurant_page.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
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
      bottomNavigationBar: _buildBottomNavBar(context),
      body: Column(
        children: [
          Receipt(orderId:context.read<Restaurant>().currentOrder as String, db:db),

        Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(8)
          ),
        child: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('orders').doc(context.read<Restaurant>().currentOrder as String?).snapshots(),
          builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
    
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text("Nenhum pedido não encontrado. :(",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              );
                }

                String status = snapshot.data!.data()?['status'] ?? "Desconhecido";
                String estimatedDeliveryTime = snapshot.data!.data()?['estimatedDeliveryTime'] ?? "Desconhecido";

                return Column(
                          children: [
                              Text(status,
                                  style: TextStyle(fontSize: 18)
                              ),
                              Text(estimatedDeliveryTime,
                                  style: TextStyle(fontSize: 16)
                              ),
                          ],
                );
            },
          )

          )
        ),

          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Faltou alguma coisa?", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary)),
          const SizedBox(width: 4,),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ChatPage()));
            },
            child: Text("Contatar Restaurante", 
            style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold)),
          )
          
        ],)
        ],
      ),
    );
  }

  // Custom Bottom Nav Bar
  Widget _buildBottomNavBar(BuildContext context){
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // driver profile pic
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.person)),
          ),

          const SizedBox(width: 10,),

          // driver details

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("José Pereira",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary
                ),),
                Text("Motorista",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary)
                ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
          // message button
           Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: (){

                
              }, 
              icon: Icon(Icons.message)),
          ),
          
          const SizedBox(width: 10,),


            ],
          )

        ],
      ),
    );
  }
}
