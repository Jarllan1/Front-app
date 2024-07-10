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
  String email = '';
  String password = '';
  bool _obscure = true;
  bool _isLoading = false; // Track the loading state

  Future<void> login(User user) async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.194.25:8080/api/v1/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'usernameOrEmail': user.email,
          'password': user.password,
        }),
      );

      if (response.statusCode == 200) {
        // Handle the response
        print('Login successful');
        // Navigate to the next page or perform any action on successful login
      } else {
        // Handle the error
        print('Failed to login: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false after request completes
      });
    }
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
                  fontWeight: FontWeight.bold,
                  fontSize: 30.5,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 25.0),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onSaved: (value) {
                        email = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                        ),
                      ),
                      onSaved: (value) {
                        password = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a password';
                        }
                        if (value.length < 8) {
                          return 'Password should be at least 8 characters long';
                        }
                        if (value.length > 20) {
                          return 'Password too long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        User user = User(
                          username: '', // If you need username, you should have a field for it
                          email: email,
                          password: password,
                        );

                        if (!_isLoading) {
                          login(user); // Call the login function
                        }
                      }
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: _isLoading
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text('Log In'), // Display loading spinner or text
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300],
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70.0),
              Text(
                'Sign in with.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Log In with Facebook'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Log In with Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already have an account?'),
                  SizedBox(width: 10.0),
                  InkWell(
                    child: Text(
                      'Sign up here',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                    onTap: () => Navigator.popAndPushNamed(context, '/signup'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
