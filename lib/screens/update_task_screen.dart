import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateTaskScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const UpdateTaskScreen({super.key, required this.documentSnapshot});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {

  var taskC = TextEditingController();


  @override
  void initState() {
    taskC.text = widget.documentSnapshot['taskName'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Update Task'),
      ),
      
      body: Column(children: [
        TextField(controller: taskC,),
        ElevatedButton(onPressed: () async {

          String taskName = taskC.text.trim();
          String uid = FirebaseAuth.instance.currentUser!.uid;
         await FirebaseFirestore.instance.collection('tasks').doc(uid)
          .collection('tasks').doc(widget.documentSnapshot['taskId'])
          .update({
            'taskName': taskName,
          });

         Navigator.of(context).pop();

        }, child: const Text('Update'))
      ],),
    );
  }
}
