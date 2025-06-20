import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  bool _isAnswerSelected = false;
  String _answerFeedback = '';

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    String data = await rootBundle.loadString('assets/questions.json');
    setState(() {
      _questions = json.decode(data);
    });
  }

  void _answerQuestion(bool isCorrect) {
    setState(() {
      if (!_isAnswerSelected) {
        _isAnswerSelected = true;
        _answerFeedback = isCorrect ? '🎉 Correct!' : '❌ Incorrect!';
        if (isCorrect) {
          _score++;
        }
        if (_currentQuestionIndex < _questions.length - 1) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              _currentQuestionIndex++;
              _isAnswerSelected = false;
              _answerFeedback = '';
            });
          });
        } else {
          _quizCompleted = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent, // 🌟 Fun, bright background
      appBar: AppBar(
        title: Text('CyberQuiz', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrange, // 🎨 Colorful app bar
      ),
      body: _quizCompleted
          ? ResultScreen(score: _score, total: _questions.length)
          : _questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Text(
                  _questions[_currentQuestionIndex]['question'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ..._questions[_currentQuestionIndex]['options'].asMap().entries.map(
                    (entry) {
                  int index = entry.key;
                  String option = entry.value;
                  List<Color> buttonColors = [
                    Colors.lightBlue,
                    Colors.green,
                    Colors.purple,
                    Colors.redAccent
                  ];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: _isAnswerSelected
                          ? null
                          : () => _answerQuestion(
                        option == _questions[_currentQuestionIndex]['answer'],
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: buttonColors[index % buttonColors.length], // 🎨 Colorful buttons
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ).toList(),
              SizedBox(height: 20),
              if (_isAnswerSelected)
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: Text(
                    _answerFeedback,
                    key: ValueKey<String>(_answerFeedback),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _answerFeedback == '🎉 Correct!' ? Colors.green : Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
