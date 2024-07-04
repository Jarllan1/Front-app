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
      appBar:AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.limeAccent,
        centerTitle: true,
      ),
      body: Container(
        child:SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.limeAccent)),
                  onPressed: (){
                    Navigator.pushNamed(context, '/menu');
                  },
                  child: Text('Go to Menu'),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.limeAccent)),
                  onPressed: (){
                    Navigator.pushNamed(context, '/profile');
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
