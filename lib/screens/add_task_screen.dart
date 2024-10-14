import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  var taskC = TextEditingController();

  @override
  void dispose() {
    taskC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Column(
        children: [
          TextField(
            controller: taskC,
          ),
          ElevatedButton(onPressed: () async {

            String taskName = taskC.text.trim();

            if( taskName.isNotEmpty){
              int dt = DateTime.now().millisecondsSinceEpoch;

              String uid = FirebaseAuth.instance.currentUser!.uid;

              var taskRef = FirebaseFirestore
                  .instance
                  .collection('tasks')
                  .doc(uid)
                  .collection('tasks')
                  .doc();

              await taskRef.set({
                'taskName': taskName,
                'dt': dt,
                'taskId': taskRef.id,
              });

              Navigator.of(context).pop();
            }

          }, child: const Text('Save'))
        ],
      ),
    );
  }
}
