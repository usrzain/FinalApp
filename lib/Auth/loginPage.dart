// ignore_for_file: unnecessary_cast, use_build_context_synchronously, empty_catches, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:EvNav/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EvNav/Auth/SignupPage.dart';
import 'package:EvNav/Auth/HomePage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true; // Add this line to declare _isObscure

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? loggedInUser;

  void getUserDetails(email) async {
    try {
      final emailQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      for (var doc in emailQuery.docs) {
        final userData = doc.data() as Map<String, dynamic>;
        // Access specific user details using keys in the map
        final name = userData['username'];
        final email =
            userData['email']; // This will be the same email used in the query

        final brand = userData['defaultBrand'];
        final model = userData['defaultModel'];
        // final contFav = userData.containsKey('favorites');
        // final contBook = userData.containsKey('bookings');
        setState(() {
          Provider.of<chDataProvider>(context, listen: false).userData =
              Map.from(userData);
          Provider.of<chDataProvider>(context, listen: false)
              .markerLoadingComplete = false;

          // Access other user details based on field names
          // Map<String, dynamic>? fetchUser = {'email': email, 'username': name};
          Provider.of<chDataProvider>(context, listen: false).userEmail = email;
          Provider.of<chDataProvider>(context, listen: false).userName = name;

          Provider.of<chDataProvider>(context, listen: false).defaultBrand =
              brand;
          Provider.of<chDataProvider>(context, listen: false).defaultModel =
              model;

          Provider.of<chDataProvider>(context, listen: false)
              .profileFetchingDone = true;
          Provider.of<chDataProvider>(context, listen: false)
              .userFetchDuringOrAfterLogin = true;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70.0),
              Image.asset(
                'assets/electric-car.png',
                width: 250.0,
                height: 250.0,
                alignment: const Alignment(-55.0 / 321.0, -109.0 / 321.0),
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 8.0),
              const Text(
                "Let's you in",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF707070),
                  prefixIcon: const Icon(Icons.mail, color: Colors.white),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF707070),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 55),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blueAccent,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: _loginWithEmailAndPassword,
                  child: const Text("Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an Account? ",
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 15,
                        color: Colors.white,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 19),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginWithEmailAndPassword() async {
    FocusScope.of(context).unfocus();
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      loggedInUser = FirebaseAuth.instance.currentUser;
      getUserDetails(loggedInUser!.email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          // Handle user not found error
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "User Not found",
          );
          break;
        case 'wrong-password':
          // Handle wrong password error
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Wrong password ! please enter correct password",
          );
          break;
        case 'invalid-email':
          // Handle invalid email error
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Email address is not found ",
          );
          break;
        case 'user-disabled':
          // Handle user disabled error
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Your account has been disabled, Please use another account",
          );
          break;
        // Add more cases as needed for other errors
        default:
          // Handle other errors
          break;
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('${e.message}'),
      //   ),
      // );
    }
  }
}
