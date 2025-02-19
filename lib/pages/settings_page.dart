import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/components/custom_settings_button.dart";
import "package:flutter_application_1/services/notifications_provider.dart";
import "package:flutter_application_1/themes/theme_provider.dart";
import "package:provider/provider.dart";

class SettingsPage extends StatelessWidget{

  const SettingsPage({
    super.key
    });

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // dark or light mode
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
            padding: const EdgeInsets.all(25),
            child: 
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dark Mode", style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Theme.of(context).colorScheme.inversePrimary)
                        ),
                    // switch
                    Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) => CupertinoSwitch(
                          value: themeProvider.isDarkMode,
                          onChanged: (value) => themeProvider.toggleTheme(),
                        )
                      ),
                  ],
              ),
          ),
          
          // notifications settings
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
            padding: const EdgeInsets.all(25),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Column(
                    children: [
                      Text("Notificações", 
                        style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  color: Theme.of(context).colorScheme.inversePrimary
                                )
                      ),
                       Text("Ativar ou desativar notificações sobre ofertas e promoções.", 
                        style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary
                                )
                      ),
                    ],
                  ),
                  Consumer<NotificationProvider>(
                        builder: (context, notificationProvider, child) => CupertinoSwitch(
                        value: notificationProvider.notificationsEnabled,
                        onChanged: (value) => notificationProvider.toggleNotifications(),
                      )
                  ),
                ],
            ),
          ),
          
          // change email
          CustomOptionsButton(
            text: "Alterar Email", 
            onTap: (){


          }),

          // change password

          // credit cards options

          // add birthday

          // delete account

          // privacy policy

          // support contact

          // suggestions and feedbacks

        ],


      )
    );
  }
}