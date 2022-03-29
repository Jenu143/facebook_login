import 'package:fb/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        appBar: AppBar(
          title: const Text(
            "Facebook Login",
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          child: _isLoggedIn
              ? HomeScreen(
                  image: _userObj["picture"]["data"]["ur l"] ?? "https://www.freeiconspng.com/thumbs/facebook-logo-png/facebook-splat-f-logo-transparent-28.png",
                  name: '${_userObj["name"] ?? "Name not found!"}',
                  email: '${_userObj["name"] ?? "Name not found!"}',
                  press: () {
                    FacebookAuth.instance.logOut().then((value) {
                      setState(() {
                        _isLoggedIn = false;
                        _userObj = {};
                      });
                    });
                  })
              : LoginScreen(
                  press: () async {
                    FacebookAuth.instance.login(
                        permissions: ["public_profile", "email"]).then((value) {
                      FacebookAuth.instance.getUserData().then((userData) {
                        setState(() {
                          _isLoggedIn = true;
                          _userObj = userData;
                        });
                      });
                    });
                  },
                ),
        ),
      ),
    );
  }
}

//! login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    required this.press,
  }) : super(key: key);
  final VoidCallback press;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.45),
              Colors.white.withOpacity(0.04),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                "Login with Facebook",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: widget.press,
            ),
            const Icon(
              Icons.login_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
