import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jarllan/Services/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome for icons

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
  String confirmPassword = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  IconData _obscurePasswordIcon = Icons.visibility_off;
  IconData _obscureConfirmPasswordIcon = Icons.visibility_off;

  Future<void> createAccount(User user) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-api-url.com/api/v1/auth/register/user'), // Ensure HTTPS is used
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': user.username,
          'email': user.email,
          'password': user.password,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, navigate to the login page
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Handle other responses (e.g., 4xx, 5xx errors)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: Center(
          child: Text(
            'ℒℯ𝒶𝒻 ℰ𝓈𝓈ℯ𝓃𝒸ℯ',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.green[300],
        elevation: 0, // Remove the shadow
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/leaf.png',
                    width: MediaQuery.of(context).size.width * 0.9, // Adjust width to fit the screen
                    height: MediaQuery.of(context).size.width * 0.7, // Adjust height proportionally
                    fit: BoxFit.contain, // Ensure image scales well
                  ),
                ),
                SizedBox(height: 25.0),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      SizedBox(height: 15.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.envelope), // Email icon
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide an email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        maxLength: 30,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock), // Lock icon
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePasswordIcon),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                                _obscurePasswordIcon = _obscurePassword ? Icons.visibility_off : Icons.visibility;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
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
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        maxLength: 30,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock), // Lock icon
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPasswordIcon),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                                _obscureConfirmPasswordIcon = _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                      ),
                      SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (password == confirmPassword) {
                              User user = User(username: username, email: email, password: password);
                              createAccount(user);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Passwords do not match')),
                              );
                            }
                          }
                        },
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[300],
                          foregroundColor: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: InkWell(
                          child: Text(
                            'Log in here',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
