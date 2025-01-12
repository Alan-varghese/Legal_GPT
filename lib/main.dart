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

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  // Prompts and Colors
  final List<String> prompts = [
    "Let's Explore",
    "Let's Create",
    "Let's Event",
    "Let's Brainstorm",
    "Let's Go",
  ];

  final List<Color> backgroundColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.blue,
  ];

  int _currentIndex = 0; // Current prompt index
  late AnimationController _controller;
  late Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Start timer to update prompt and background every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % prompts.length;

        // Start background color animation
        _backgroundAnimation = ColorTween(
          begin: backgroundColors[_currentIndex],
          end: backgroundColors[(_currentIndex + 1) % prompts.length],
        ).animate(_controller);

        _controller.forward(from: 0.0);
      });
    });

    // Initialize first animation
    _backgroundAnimation = ColorTween(
      begin: backgroundColors[0],
      end: backgroundColors[1],
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: _backgroundAnimation.value, // Dynamic background color
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title: Legal GPT
                Text(
                  "Legal GPT",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Fixed white text
                  ),
                ),
                SizedBox(height: 20),
                // Prompt text
                Text(
                  prompts[_currentIndex],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Fixed white text
                  ),
                ),
                SizedBox(height: 40),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    // Handle Sign Up
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue, backgroundColor: Colors.white,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Handle Login
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
