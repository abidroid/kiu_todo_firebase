import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:kiu_todo_firebase/screens/add_task_screen.dart';
import 'package:kiu_todo_firebase/screens/login_screen.dart';
import 'package:kiu_todo_firebase/screens/update_task_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  CollectionReference? collectionReference;

  @override
  void initState() {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    collectionReference = FirebaseFirestore
        .instance
        .collection('tasks')
        .doc(uid)
        .collection('tasks');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.of(context).push(MaterialPageRoute(builder: (cntext){
          return const AddTaskScreen();
        }));
      }, child: Icon(Icons.add,),),
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: const Text('Dashboard'),
        actions: [
          
          IconButton(onPressed: (){}, icon: Icon(Icons.person)),
          IconButton(onPressed: (){

            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('Confirmation'),
                content: const Text('Are you sure to Log Out ?'),

                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text('No')),
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();

                    FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return const LoginScreen();
                    }));

                  }, child: const Text('Yes')),
                ],
              );
            });



          }, icon: Icon(Icons.logout )),

        ],
      
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: collectionReference!.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if( snapshot.hasData){

              List list = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text(list[index]['taskName']),
                    subtitle: Text(getHumanReadableDate(list[index]['dt'])),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () async {

                          await collectionReference!.doc(list[index]['taskId']).delete();


                        }, icon: Icon(Icons.delete)),
                        IconButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return UpdateTaskScreen(documentSnapshot: list[index]);
                          }));

                        }, icon: Icon(Icons.edit)),

                      ],
                    ),
                  ),
                );
              });



            }else{
              return Center(child: SpinKitDualRing(color: Colors.green),);
            }
          }),
    );
  }
  
  
  String getHumanReadableDate( int dt)
  {
    DateFormat dateFormat = DateFormat('dd-MMM-yyyy hh:mm');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dt);
    String insaaniDate = dateFormat.format(date);
    return insaaniDate;
  }
  
  
  
}
