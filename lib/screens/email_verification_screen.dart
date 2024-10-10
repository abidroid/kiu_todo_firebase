import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';

import 'dashboard_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  Timer? timer;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5),(timer) {
      checkEmailVerification();
    });

  }

  // execute every 5 seconds
  checkEmailVerification() {
    FirebaseAuth.instance.currentUser!.reload();

    if(  FirebaseAuth.instance.currentUser!.emailVerified){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return const DashboardScreen();
      }));
    }

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Verify'),
      ),
      body: Column(children: [
        Text('An Email has been sent to ${FirebaseAuth.instance.currentUser!.email}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
       const Gap(20),
        const Text('Please Verify It',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
        const Gap(20),

        SpinKitCircle(color: Colors.green,),
        const Gap(20),

        ElevatedButton(onPressed: (){

          FirebaseAuth.instance.currentUser!.sendEmailVerification();

        }, child: const Text('Resend Email'))
      ],),
    );
  }
}
