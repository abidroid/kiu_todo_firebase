import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var nameC = TextEditingController();
  var mobileC = TextEditingController();
  var emailC = TextEditingController();
  var passC = TextEditingController();
  var confirmPassC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Sign Up Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const Gap(16),
            TextField(
              controller: mobileC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mobile',
              ),
            ),
            const Gap(16),

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

            const Gap(16),
            TextField(
              controller: confirmPassC,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Confirm Password',
              ),
            ),

            const Gap(16),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {

                  String name = nameC.text.trim();
                  String mobile = mobileC.text.trim();
                  String email = emailC.text.trim();
                  String pass = passC.text.trim();
                  String confirmPass = confirmPassC.text.trim();

                  // Todo: check for empty fields validation

                  if( pass.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Weak Password. At least 6 characters are required'))
                    );
                    return;
                  }

                  if( pass != confirmPass){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match'))
                    );
                    return;
                  }


                  try {
                    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);

                    if( userCredential.user != null ){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Success'))
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed'))
                      );
                    }
                  }
                  on FirebaseAuthException catch (e ){
                    ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(e.toString()))
                    );
                  }


                }, child: const Text('SIGN UP')),

            const Gap(16),


          ],
        ),
      ),
    );
  }
}
