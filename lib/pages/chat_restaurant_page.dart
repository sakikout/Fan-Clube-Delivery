import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirestoreService db = FirestoreService();
  final TextEditingController textController = TextEditingController();


  @override
  void initState(){
    super.initState();
  }

  void sendMessage(){
    String message = textController.text;
    if (message.isNotEmpty) {
      db.sendMessage("restaurant", message);
      textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat com Restaurante"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: Column(
        children: [
          Row(children: [
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("Fã Clube",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary
                ),),
                Text("Restaurante",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary)
                ),
            ],
          ),

          // messages
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: db.getMessages("restaurant"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text("Nenhuma mensagem ainda."));
                        }

                      // Lista de mensagens
                      return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var message = snapshot.data![index];
                              bool isMe = message['senderId'] == FirebaseAuth.instance.currentUser!.uid;
                              return Align(
                                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                                  child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                          color: isMe ? Colors.blue : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(message['message'], style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                                      ),
                                    );
                            },
                          );
                      },
                    ),
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

          // input
          CustomTextfield( 
          controller: textController,
          hintText: "Digite sua mensagem aqui.",
          obscureText: true,
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
              onPressed: sendMessage, 
              icon: Icon(Icons.send)),
          ),
          
          const SizedBox(width: 10,),


            ],
          )

        ],
      ),
    );
  }
}
