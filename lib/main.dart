import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home:Scaffold(
      appBar: AppBar(
       title: const Center (
        child:  Text('Front App'),
       ),
        backgroundColor: Colors.teal[400],
      ),
      body:  Center(
        child: Text(
            'Ayos na kainan na',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[200],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.add_moderator_outlined,
          color: Colors.indigoAccent,
        ),
          ),
        ),
      ),
    );
}

