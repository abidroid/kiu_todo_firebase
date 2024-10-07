import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        
      }, child: Icon(Icons.add,),),
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: const Text('Dashboard'),
        actions: [
          
          IconButton(onPressed: (){}, icon: Icon(Icons.person)),
          IconButton(onPressed: (){}, icon: Icon(Icons.logout)),

        ],
      
      ),
    );
  }
}
