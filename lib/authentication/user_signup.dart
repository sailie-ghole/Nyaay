// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:nyaay/pages/user/home/home1.dart';
import 'login.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  // final cityController = TextEditingController();
  // final districtController = TextEditingController();
  // final stateController = TextEditingController();

  FutureOr<void> addUser() async {
    // CollectionReference users = FirebaseFirestore.instance.collection('service');
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final String? uid = auth.currentUser?.email;
    // await users.doc(uid).set({
    //   'date': DateTime.now(),
    // });
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(emailController.text.trim());
    await ref.set({
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      // "phone": phoneController.text.trim(),
      // "city": cityController.text.trim(),
      // "district": districtController.text.trim(),
      // "state": stateController.text.trim(),
      "profession": professionController.text.trim()
    });
  }

  void signUp() {
    final isValid = formKey.currentState!.validate();
    if (isValid == false) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account Created Successfully!")));
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      throw "error";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: SingleChildScrollView(
          padding: EdgeInsets.all(22.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                SizedBox(
                  height: 45.0,
                ),
                Text(
                  'Save More with MyMoney',
                  style: TextStyle(
                    fontFamily: 'CrimsonText',
                    // fontStyle: FontStyle.italic,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: nameController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: emailController,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email, true)
                          ? "Enter a valid email"
                          : null,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: professionController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Profession",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: phoneController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? "Enter minimum 6 characters"
                      : null,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[900]),
                    ),
                    onPressed: () {
                      signUp();
                    },
                    icon: Icon(Icons.lock_open_rounded),
                    label: _isLoading
                        ? SizedBox(
                            height: MediaQuery.of(context).size.width / 12,
                            width: MediaQuery.of(context).size.width / 12,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 1,
                            ),
                          )
                        : Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 17.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CrimsonText',
                          fontSize: 16),
                      'Already have an account?   ',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyLogin()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontFamily: 'CrimsonText',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
