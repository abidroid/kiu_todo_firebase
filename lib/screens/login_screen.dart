import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kiu_todo_firebase/screens/dashboard_screen.dart';
import 'package:kiu_todo_firebase/screens/forgot_password_screen.dart';
import 'package:kiu_todo_firebase/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailC = TextEditingController();
  var passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            TextField(
              controller: emailC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const Gap(16),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ForgotPasswordScreen();
                  }));
                }, child: const Text('Forgot Password?'))),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const DashboardScreen();
                  }));

                }, child: const Text('LOGIN')),

            const Gap(16),

            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return const SignUpScreen();
              }));

            }, child: const Text('Not Registered Yet? SignUp Now'))

          ],
        ),
      ),
    );
  }
}
