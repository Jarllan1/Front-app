import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int year = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.limeAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/reindeer.png'),
                    radius: 50.0,
                  ),
                ),
                Divider(height: 75.0,color:Colors.black87,thickness: 4.0,),
                Row(
                  children: [
                    Icon(
                        Icons.person_2,
                        color: Colors.limeAccent,
                    ),
                    SizedBox(width: 3.0,),
                    Text(
                      'NAME:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Jarllan C. Eleponga',
                  style: TextStyle(
                    fontSize:25.0 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Icon(Icons.calendar_month,
                    color: Colors.limeAccent,
                    ),
                    SizedBox(width: 3.0,),
                    Text(
                      'YEAR:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  '$year year',
                  style: TextStyle(
                    fontSize:25.0 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Icon(Icons.email_sharp,
                    color: Colors.limeAccent,
                    ),
                    SizedBox(width: 3.0,),
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Evayne8@gmail.com',
                  style: TextStyle(
                    fontSize:25.0 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                ElevatedButton(
                   style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.limeAccent)),
                  onPressed: (){
                     setState(() {
                       year+= 1;
                     });
                  },
                    child: Text(
                        'Add Year',
                    style: TextStyle(
                      color: Colors.black87,

                    ),
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


