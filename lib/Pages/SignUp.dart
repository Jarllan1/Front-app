import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jarllan/Services/user.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;
  createAccount(User user) async{
    final response = await http.post(
      Uri.parse('http://192.168.194.25:8080/api/v1/auth/register/user'),
      headers :   <String, String>{
        'content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonEncode (<String, dynamic>{
          'username' : user.username,
          'email': user.email,
          'password': user.password,
        }),
      );
    print(response.body);
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
                'Let\'s Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.5,
                  color: Colors.lightGreen,
                ),
              ),
              SizedBox(height: 25.0),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a name';
                        }
                        if (value.length < 3) {
                          return 'Name should be at least 3 letters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide an email';
                        }
                        // Add more email validation logic if needed
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                    SizedBox(height: 25.0,),
                    TextFormField(
                      maxLength: 30,
                      enableInteractiveSelection: false,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.lock_open_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureIcon),
                          onPressed: (){
                            setState(() {
                              _obscure = !_obscure;
                              if(_obscure){
                                _obscureIcon = Icons.visibility_off;
                              }
                              else{
                                _obscureIcon = Icons.visibility;
                              }
                            });
                          },
                        ),
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
                        return null;
                      },

                      onSaved: (value){
                        password = value!;
                      },
                    ),

                    SizedBox(height: 40.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                             User user = User(username: username,
                                 email: email,
                                 password: password);
                             createAccount(user);
                             Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          child: Text('Sign up'),
                          style:ElevatedButton.styleFrom(
                            backgroundColor:  Colors.green[300],
                            foregroundColor: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

