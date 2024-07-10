import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:jarllan/Services/User.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
final formKey = GlobalKey<FormState>();
String name ='';
String email ='';
String password='';
bool _obscure = true;

login(User user) async {
  final response = await http.post(
    Uri.parse('http: // 10.0.2.2:8080/api/v1/auth/login'),
    headers: <String, String>{
      'content-Type' :'application/json; charset=UTF-8'
    },
    body: jsonEncode (<String, dynamic>){
      'usernameOrEmail' : user.email;
      'password' : user.password
  }
  ),
}
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.lime,
       body: SafeArea(
         child: Padding(
           padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
           child: Column(
             children: <Widget>[
               Text(
                 'LogIn',
                 style: TextStyle(
                   fontWeight: FontWeight.bold, fontSize: 30.5,
                   color: Colors.black87
                 ),
               ),
                SizedBox(height: 25.0,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                         TextFormField(
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration(
                             label: Text('Email'),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20.0)
                             ),
                           ),
                         ),
                         SizedBox(height: 25.0,),
                         TextFormField(
                           obscureText: true,
                           decoration: InputDecoration(
                             label: Text('Password'),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20.0)
                             ),
                           ),
                           validator: (value){
                             if(value == null || value.isEmpty){
                               return'Please provide a password';
                             }
                             if(value.length < 8){
                               return 'Password shoul be atleast 8 characters long';
                             }
                             if(value.length > 20){
                               return 'Too long';
                             }
                           },
                           ),
                           ],
                         ),
                    ),
                         SizedBox(height: 40.0,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                         ElevatedButton(
                           onPressed: (){
                            // Navigator.pushReplacementNamed(context, '/dashboard');
                             if(formKey.currentState!.validate()){
                               formKey.currentState!.save();
                              User user = User(
                                username: '',
                                email: email,
                                password:  password
                              );
                              login(user);
                             }
                           },
                           child: Text('Log In'),
                           style:ElevatedButton.styleFrom(
                             backgroundColor:  Colors.green[300],
                             foregroundColor: Colors.black87,
                           ),
                         ),
                         ],
                         ),

           SizedBox(height: 70.0,),
               Text('Sign in with.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
               ),

           SizedBox(height: 40,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               ElevatedButton(
                    onPressed: (){},

                 child: Text('Log In with Facebook'),
                 style:ElevatedButton.styleFrom(
                   backgroundColor:  Colors.blueAccent,
                   foregroundColor: Colors.black87,
                 ),
               ),
             ],
           ),
               SizedBox(height: 20.0,),
               Column(

                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   ElevatedButton(
                     onPressed: (){},

                     child: Text('Log In with Goole'),
                     style:ElevatedButton.styleFrom(
                       backgroundColor:  Colors.white,
                       foregroundColor: Colors.black87,
                     ),
                   ),


           ],
                   ),
           SizedBox(height: 40.0),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Already have an account?'
               ),
               SizedBox(height: 10.0,),
                InkWell(
                  child:  Text(
                    'Sign up here',
                    style: TextStyle(
                      color: Colors.deepOrange
                    ),
                  ),
                  onTap: ()=> Navigator.popAndPushNamed(context, '/signup'),
                )
             ],
           )
  ],
           ),
       ),
     ),
     );

  }
}
