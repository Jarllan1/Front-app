import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  // Import FontAwesome for icons
import 'package:jarllan/Services/User.dart';  // Ensure this import path matches your project structure

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
        Navigator.pushReplacementNamed(context, '/dashboard'); // Navigate to the dashboard on success
      } else {
        // Handle the error
        print('Failed to login: ${response.body}');
        _showErrorDialog('Failed to login: ${response.body}');  // Show the error message
      }
    } catch (e) {
      print('Error occurred: $e');
      _showErrorDialog('An error occurred: $e');  // Show the error message
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false after request completes
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,  // Allows dismissing the dialog by tapping outside
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text('ℒℯ𝒶𝒻 ℰ𝓈𝓈ℯ𝓃𝒸ℯ',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        centerTitle: true,
        // Removed the leading property to hide the back button
      ),
      body: Center( // Center the content vertically and horizontally
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Log In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.5,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center, // Center the text
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
                        prefixIcon: Icon(FontAwesomeIcons.envelope), // Add email icon
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
                        prefixIcon: Icon(FontAwesomeIcons.lock), // Add lock icon
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
              SizedBox(height: 20.0),
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
                      } else {
                        // Display error messages for invalid email or password
                        setState(() {
                          // Clear any existing error message
                        });
                      }
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
              SizedBox(height: 20.0), // Add some space between buttons
              Text(
                'Sign in with.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white), // Facebook icon
                    label: Text('Log In with Facebook'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.google, color: Colors.red), // Google icon
                    label: Text('Log In with Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.0),
              Center(
                child: Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 10.0), // Add some space between text and link
              Center(
                child: InkWell(
                  child: Text(
                    'Sign up here.',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
                ),
              ),
              SizedBox(height: 20.0), // Add some space from the bottom
            ],
          ),
        ),
      ),
    );
  }
}
