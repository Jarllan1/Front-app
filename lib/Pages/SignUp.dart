import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();

}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  String name ='';
  String email ='';
  String password='';
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
          child:Column(
            children: <Widget>[
              Text(
                'Lets Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
              ),
              SizedBox(height: 25.0,),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text('Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return'Please provide a name';
                        }
                        if(value.length < 2){
                          return 'Name should be atleast 3 letters long';
                        }
                        return null;
                      },
                      onSaved: (value){
                        password = value!;
                      },
                    ),
                    SizedBox(height: 25.0,),
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
                    ElevatedButton(
                        onPressed: (){
                         if(formKey.currentState!.validate()){
                           formKey.currentState!.save();
                           print(name);
                           print(email);
                           print(password);
                         }
                        },
                        child: Text('Sign up'),
                        style:ElevatedButton.styleFrom(
                          backgroundColor:  Colors.lightGreen,
                          foregroundColor: Colors.black87,
                        ),
                    ),
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
