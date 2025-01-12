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

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.blue,
  ];

  int _currentIndex = 0; // Current prompt index
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Fading effect
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Scaling effect
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the timer to switch prompts every 2 seconds
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % prompts.length;
      });
      _controller.forward(from: 0.0);
    });

    // Start the animation
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
                // Animated Prompts with Effects
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value, // Fading effect
                      child: Transform.scale(
                        scale: _scaleAnimation.value, // Scaling effect
                        child: Text(
                          prompts[_currentIndex], // Current prompt
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors[_currentIndex], // Dynamic color
                          ),
                        ),
                      ),
                    );
                  },
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
