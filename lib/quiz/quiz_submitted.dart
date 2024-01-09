import 'package:campusclap/Models/content_model.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'check_quiz_result.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuizSubmitted extends StatelessWidget {
  final List<QuizQuestion>? questions;
  final Map<int, dynamic>? answers;

  int? correctAnswers;
  QuizSubmitted({this.questions, this.answers});
 // QuizSubmitted({Key? key, this.questions,this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    this.answers!.forEach((index, value) {
      if (this.questions![index].correct == value) correct++;
    });
    final TextStyle titleStyle = TextStyle(
        color: colors.textColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: colors.primary,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      backgroundColor: colors.whiteTemp,
      //appBar: customAppBar(context, "Quiz_Result"),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight( 80),
          child:

          commonAppBar(context,text: 'Quiz_Result') ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x1c2464).withOpacity(0.30),
                      blurRadius: 25.0,
                      offset: Offset(0.0, 20.0),
                      spreadRadius: -15.0)
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      title:
                          Text("Total_Questions", style: titleStyle),
                      trailing:
                          Text("${questions!.length}", style: trailingStyle),
                    ),
                    ListTile(
                      title: Text("Score_", style: titleStyle),
                      trailing: Text("${correct / questions!.length * 100}%",
                          style: trailingStyle),
                    ),
                    ListTile(
                      title:
                          Text("Correct_Answers", style: titleStyle),
                      trailing: Text("$correct/${questions!.length}",
                          style: trailingStyle),
                    ),
                    ListTile(
                      title: Text("Incorrect_Answers",
                          style: titleStyle),
                      trailing: Text(
                          "${questions!.length - correct}/${questions!.length}",
                          style: trailingStyle),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Back_",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: colors.textColor),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: colors.primary,
                  ),
                  child: Text(
                    "Show_Report",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CheckQuizResult(
                          questions: questions,
                          answers: answers,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
