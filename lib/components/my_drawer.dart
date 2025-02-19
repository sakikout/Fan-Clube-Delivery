import "package:flutter/material.dart";
import "package:flutter_application_1/components/my_drawer_tile.dart";
import "package:flutter_application_1/pages/deliveries_page.dart";
import "package:flutter_application_1/pages/settings_page.dart";
import "package:flutter_application_1/services/auth/auth_service.dart";

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  void logout(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build (BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset("assets/logo/fa_clube_logo.png",
          height: 200,
          width: 200,),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          
          // home list
          MyDrawerTile(
            text: "Home", 
            icon: Icons.home, 
            onTap: () => Navigator.pop(context)),

          // delivery page
          MyDrawerTile(
            text: "Entregas", 
            icon: Icons.delivery_dining, 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const DeliveryHistoryPage()));
            }),

          MyDrawerTile(
            text: "Notificações", 
            icon: Icons.notifications, 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const DeliveryHistoryPage()));
          }),


          // settings
          MyDrawerTile(
            text: "Configurações", 
            icon: Icons.settings, 
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SettingsPage()));
            }),

          const Spacer(),
          // logout
          MyDrawerTile(
            text: "Sair", 
            icon: Icons.logout, 
            onTap: logout),

            const SizedBox(height: 25),

      ],),
    );
  }
}