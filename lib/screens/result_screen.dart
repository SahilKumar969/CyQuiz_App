import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'quiz_screen.dart'; // Import the QuizScreen

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;

  ResultScreen({required this.score, required this.total});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _confettiController.play(); // Start confetti when screen loads 🎉
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String _getBadge() {
    double percentage = (widget.score / widget.total) * 100;
    if (percentage >= 80) {
      return '🏆 Gold Star Champion!';
    } else if (percentage >= 50) {
      return '🥈 Silver Cyber Defender!';
    } else {
      return '🥉 Bronze Cyber Explorer!';
    }
  }

  String _getEncouragement() {
    double percentage = (widget.score / widget.total) * 100;
    if (percentage >= 80) {
      return 'Amazing job! You are a Cyber Superstar! 🌟';
    } else if (percentage >= 50) {
      return 'Great effort! Keep learning and become a Cyber Master! 🔐';
    } else {
      return 'Nice try! Keep practicing to improve your cyber skills! 🚀';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Fun & bright background
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quiz Completed! 🎉',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Score: ${widget.score} / ${widget.total}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _getBadge(),
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _getEncouragement(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // ✅ Fixed Play Again Button
                ElevatedButton(
                  onPressed: () {
                    // Reset the quiz and navigate back to the quiz screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Fun button color
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Play Again 🎮'),
                ),
              ],
            ),
          ),

          // 🎉 Confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Shoots confetti downwards
              emissionFrequency: 0.03, // Continuous confetti
              numberOfParticles: 20,
              gravity: 0.2,
              shouldLoop: false,
              colors: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.purple
              ], // 🎨 Colorful confetti
            ),
          ),
        ],
      ),
    );
  }
}
