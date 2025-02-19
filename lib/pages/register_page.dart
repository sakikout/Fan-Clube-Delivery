import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_textfield.dart';
import 'package:flutter_application_1/components/custom_button.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/services/auth/database/firestore.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap,});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  // text editing controllers
  FirestoreService db = FirestoreService();
  
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState(){
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

  }

  @override
  void dispose(){
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();

  }
  // register method

  void register() async {
    // get auth service

    final _authService = AuthService();

    // check if passwords match
    if (_passwordController.text == _confirmPasswordController.text){
      // try creating user
      try {
        UserCredential userCredential= await _authService.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);
      
      String userId = userCredential.user!.uid;

      AppUser newUser = AppUser(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          createdAt: DateTime.now(),
          creditCards: [],
          address: ' '
        );

        db.saveUserToDatabase(userId, newUser);
        print("Usuário cadastrado com sucesso!");
      
      } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ));
      }
    } else {
      // if passwords don't match
         showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: Text("As senhas precisam ser as mesmas."),
        ));

    }

  }

  @override
  Widget build(BuildContext context){
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
        Text("Vamos criar uma conta para você!",
        style: TextStyle(
          fontSize: 16, 
          color: Theme.of(context).colorScheme.inversePrimary)
          ),

        const SizedBox(height: 25),
        // email textfield
        CustomTextfield( 
          controller: _firstNameController,
          hintText: "Nome",
          obscureText: false,
          ),

        const SizedBox(height: 25),
        // email textfield
        CustomTextfield( 
          controller: _lastNameController,
          hintText: "Sobrenome",
          obscureText: false,
          ),

        const SizedBox(height: 25),
        // email textfield
        CustomTextfield( 
          controller: _emailController,
          hintText: "Email",
          obscureText: false,
          ),

        const SizedBox(height: 25),

        // password textfield
        CustomTextfield( 
          controller: _passwordController,
          hintText: "Senha",
          obscureText: true,
          ),

        const SizedBox(height: 25),

        // confirm password textfield
        CustomTextfield( 
          controller: _confirmPasswordController,
          hintText: "Confirmar Senha",
          obscureText: true,
          ),

        const SizedBox(height: 25),
        
        // sign up button
        CustomButton(text: "Registrar-se", onTap: (){
          register();
        },),

        const SizedBox(height: 25),

        // Already have an account? Login here

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Já possui uma conta?", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary)),
          const SizedBox(width: 4,),
          GestureDetector(
            onTap: widget.onTap,
            child: Text("Entre aqui!", style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold)),
          )
          
        ],)

      ],)
        ,)
    );
  }
}
