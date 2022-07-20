import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _auth = FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: emailController.text.trim(),
  //     password: passwordController.text.trim());
  String name = "";
  String email = "";
  String pass = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset("assets/images/login3.png", fit: BoxFit.cover),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome $name",
                style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        label: Text("User Name"),
                        hintText: "Enter Username",
                      ),
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text("Password"),
                        hintText: "Enter password",
                      ),
                      onChanged: (value) {
                        pass = value;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        } else if (value == null || value.length < 6) {
                          return 'Password lenght should be atleast 6';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: 40,
                        width: changeButton ? 50 : 130,
                        alignment: Alignment.center,
                        child: changeButton
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                        decoration: BoxDecoration(
                          color: context.theme.buttonColor,
                          borderRadius:
                              BorderRadius.circular(changeButton ? 100 : 8),
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                    //   },
                    //   child: Text('Login'),
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: Colors.deepPurpleAccent,
                    //     minimumSize: Size(130, 40),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
