import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

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
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Initialize first background animation
    _backgroundAnimation = ColorTween(
      begin: backgroundColors[0],
      end: backgroundColors[1],
    ).animate(_controller);

    // Timer to change prompts and backgrounds every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % prompts.length;

        // Update background animation to transition to the next color
        _backgroundAnimation = ColorTween(
          begin: _backgroundAnimation.value,
          end: backgroundColors[_currentIndex],
        ).animate(_controller);

        _controller.forward(from: 0.0);
      });
    });

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
                // Animated Legal Icon
                Lottie.asset(
                  'assets/legal_animation.json', // Path to your Lottie file
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20),
                // Title: Legal GPT
                Text(
                  "Legal GPT",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text remains white
                  ),
                ),
                SizedBox(height: 20),
                // Dynamic Prompt Text
                Text(
                  prompts[_currentIndex],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text remains white
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
