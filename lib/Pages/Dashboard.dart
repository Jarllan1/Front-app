import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


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
                    Navigator.pushNamed(context, '/Menu');
                  },
                  child: Text('Go to Menu'),
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
