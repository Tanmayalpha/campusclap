import 'dart:io';
import 'package:campusclap/Models/content_model.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'error.dart';
import 'quiz_screen.dart';

class QuizCustomDialog extends StatefulWidget {
  final Quiz? quiz;
  final int index;

  const QuizCustomDialog({Key? key, this.quiz, required this.index}) : super(key: key);

  @override
  _QuizCustomDialogState createState() => _QuizCustomDialogState();
}

class _QuizCustomDialogState extends State<QuizCustomDialog> {
  late bool processing;

  @override
  void initState() {
    super.initState();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 150.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(widget.quiz!.course.toString()),
          SizedBox(
            height: 18.0,
          ),
          processing
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Text(
                      "Start_Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                  ),
                  onPressed: () {
                    _startQuiz();
                  },
                ),
        ],
      ),
    );
  }

  void _startQuiz() async {
    setState(() {
      processing = true;
    });
    try {
      var questions = contentModel!.quiz![widget.index].questions;
      List<QuizQuestion>? quizQuestions = questions;
      Navigator.pop(context);
      if (questions!.length < 1) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ErrorPage(
              message: "Questions_not_available",
            ),
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QuizScreen(
            questions: quizQuestions,
            quiz: widget.quiz,
          ),
        ),
      );
    } on SocketException catch (_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ErrorPage(
            message:
                "${"Cant_reach_the_servers"}, \n ${"Please_check_your_internet_connection"}",
          ),
        ),
      );
    } catch (e) {
      print(e.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ErrorPage(
            message: "Unexpected_error_trying_to_connect_to_the_API",
          ),
        ),
      );
    }
    setState(() {
      processing = false;
    });
  }
}
