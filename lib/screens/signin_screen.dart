import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback showSignUpScreen;

  const SignInScreen({Key? key, required this.showSignUpScreen})
      : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          fontSize: 18,
          backgroundColor: Colors.red.shade900
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.movie,
                size: 80,
              ),

              SizedBox(height: 10),

              Text('Welcome',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
              SizedBox(height: 50),

              //email input
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade900),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        fillColor: Colors.grey[100],
                        filled: true,
                      ))),

              SizedBox(height: 10),

              //password input
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    obscureText: true,
                  )),

              SizedBox(height: 10),
              //sign in button
              GestureDetector(
                onTap: signIn,
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text('Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                ),
              ),

              SizedBox(height: 25),
              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                  GestureDetector(
                    onTap: widget.showSignUpScreen,
                    child: Text(' Register Now',
                        style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            ]),
          ),
        )));
  }
}
