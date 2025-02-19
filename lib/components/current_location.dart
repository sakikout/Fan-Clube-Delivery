import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatefulWidget{
  final TextEditingController textController;

  const CurrentLocation({
    super.key,
    required this.textController
    });

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  FirestoreService db = FirestoreService();

    void openLocationSearchBox(BuildContext context){
      showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Sua Localização"),
        content: TextField(
          controller: widget.textController,
          decoration: const InputDecoration(
            hintText: "Inserir Endereço"
          ),
        ),
        actions: [
          //cancel button
          MaterialButton(onPressed: (){
            Navigator.pop(context);
            widget.textController.clear();
          },
          child: const Text("Cancelar")),
          // save button
          MaterialButton(onPressed: (){
            String newAddress = widget.textController.text;
            context.read<Restaurant>().updateDeliveryAddress(newAddress);
            db.updateUserAddress(newAddress);
            Navigator.pop(context);
            widget.textController.clear();
          },
          child: const Text("Salvar")),

        ],
      ));
    }

  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.all(25.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Entregar agora",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary)),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
              // address
              Consumer<Restaurant>(
                builder: (context, restaurant, child) => 
                Text( restaurant.deliveryAddress, 
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
          ),),
    
          // dropdown menu
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],),
          )
      ],
    ),);
  }
}