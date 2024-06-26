import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Container(
        child:SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.limeAccent)),
                onPressed: (){
                  Navigator.pushNamed(context, '/Dashboard');
                },
                child: Text('Go to Dashboard'),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.limeAccent)),
                onPressed: (){
                  Navigator.pushNamed(context, '/Profile');
                },
                child: Text('Go to Profile'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
