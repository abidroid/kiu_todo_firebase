import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  DocumentSnapshot? userData;


  getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    userData = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    print(userData!['name']);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Profile'),
      ),
      body: Column(children: [

      ],),
    );
  }
}
