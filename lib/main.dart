import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Prompts list
  final List<String> prompts = [
    "Let's Explore",
    "Let's Create",
    "Let's Event",
    "Let's Brainstorm",
    "Let's Go",
  ];

  // Colors list
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.blue,
  ];

  int _currentIndex = 0; // Current index for prompts

  @override
  void initState() {
    super.initState();
    // Start timer to change prompt every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % prompts.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Section
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                // Title: Legal GPT
                Text(
                  "Legal GPT",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                // Animated Prompts
                AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 500),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colors[_currentIndex], // Dynamic color
                  ),
                  child: Text(prompts[_currentIndex]), // Dynamic prompt
                ),
              ],
            ),
          ),
          // Placeholder for Bottom Section
          Expanded(
            child: Center(
              child: Text(
                "Bottom Section Placeholder",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
