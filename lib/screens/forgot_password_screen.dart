import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  var emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forogt Password ?'),
      ),
      body: ListView(
        children: [
          TextField(controller: emailC,),
          ElevatedButton(
              onPressed: () async {

                String email = emailC.text.trim();

                await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

                Navigator.of(context).pop();


              }, child: const Text('Send Password Reset Email'))
        ],
      ),
    );
  }
}
