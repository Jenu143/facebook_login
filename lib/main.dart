import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

void main() {
  runApp(
    const MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        appBar: AppBar(
          title: const Text("Facebook Login"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          child: _isLoggedIn
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(7),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.7),
                              Colors.white.withOpacity(0.099),
                            ],
                          ),
                        ),
                        child: const Text(
                          "Welcome to Home...!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                            wordSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(_userObj["picture"]["data"]
                                ["url"] ??
                            "Image not found!"),
                      ),
                      const SizedBox(height: 20),
                      //gradient text
                      GradientText(
                        '${_userObj["name"] ?? "Name not found!"}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                        gradientType: GradientType.linear,
                        colors: const [
                          Colors.red,
                          Colors.pink,
                          Colors.purple,
                          Colors.deepPurple,
                          Colors.deepPurple,
                          Colors.indigo,
                          Colors.blue,
                          Colors.lightBlue,
                          Colors.cyan,
                          Colors.teal,
                          Colors.green,
                          Colors.lightGreen,
                          Colors.lime,
                          Colors.yellow,
                          Colors.amber,
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      ),
                      const SizedBox(height: 20),

                      //shader mask text
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return RadialGradient(
                              center: Alignment.topLeft,
                              radius: 1.5,
                              colors: <Color>[
                                Colors.yellow,
                                Colors.deepOrange.shade900
                              ],
                              tileMode: TileMode.mirror,
                              stops: [0, 1]).createShader(bounds);
                        },
                        child: Text(
                          "${_userObj["email"] ?? "Email not found!"}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // log out button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.7),
                              Colors.white.withOpacity(0.099),
                            ],
                          ),
                        ),
                        child: TextButton(
                            onPressed: () {
                              FacebookAuth.instance.logOut().then((value) {
                                setState(() {
                                  _isLoggedIn = false;
                                  _userObj = {};
                                });
                              });
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )),
                      )
                    ],
                  ),
                )
              : Center(
                  child: ElevatedButton(
                    child: const Text("Login with Facebook"),
                    onPressed: () async {
                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
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
      ),
    );
  }
}
