import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.email,
    required this.press,
  }) : super(key: key);

  final String image;
  final String name;
  final String email;
  final VoidCallback press;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            "🏡",
            style: TextStyle(fontSize: 70),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(7),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.45),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
            child: const Text(
              "Welcome to  🏡Home🏡...!",
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

            child: Image.network(widget.image), //? image
          ),
          const SizedBox(height: 20),
          //gradient text
          GradientText(
            widget.name, //? name
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.2),
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
                  colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
                  tileMode: TileMode.mirror,
                  stops: [0, 1]).createShader(bounds);
            },
            child: Text(
              widget.email, //? email
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
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.04),
                ],
              ),
            ),
            child: TextButton(
              onPressed: widget.press,
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
