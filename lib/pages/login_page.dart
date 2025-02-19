import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';
import 'package:flutter_application_1/components/custom_button.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

    const LoginPage({super.key, required this.onTap});

    @override
    State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login method

  void login() async {

    // get instance of auth service
    final _authService = AuthService();

    // try sign in
    try {
      await _authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    
      Navigator.push(context, 
      MaterialPageRoute(
      builder: (context) => const HomePage()),);

    } catch (e) {
      // display any errors
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        // logo 
          Image.asset("assets/logo/fa_clube_logo.png",
          height: 200,
          width: 200,),

        const SizedBox(height: 25),
        
        // slogan
        Text("Bem-vindo de volta!",
        style: TextStyle(
          fontSize: 16, 
          color: Theme.of(context).colorScheme.inversePrimary)
          ),
        
        const SizedBox(height: 25),
        // email textfield
        CustomTextfield( 
          controller: emailController,
          hintText: "Email",
          obscureText: false,
          ),

        const SizedBox(height: 25),

        // password textfield
        CustomTextfield( 
          controller: passwordController,
          hintText: "Senha",
          obscureText: true,
          ),

        const SizedBox(height: 25),
        
        // sign in button
        CustomButton(text: "Entrar", onTap: login,),

        const SizedBox(height: 25),

        // register

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Não possui uma conta?", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary)),
          const SizedBox(width: 4,),
          GestureDetector(
            onTap: widget.onTap,
            child: Text("Registre-se agora!", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold)),
          )
          
        ],)

      ],)
        ,)
    );
  }
}