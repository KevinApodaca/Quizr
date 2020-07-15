import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/addquestion.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizID;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizID = randomAlphaNumeric(15);

      Map<String, String> quizMap = {
        "quizID": quizID,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription
      };
      await databaseService.addQuizData(quizMap, quizID).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuestion(quizID),
              ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Column(children: [
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter valid URL" : null,
                    decoration: InputDecoration(hintText: "Quiz Image Url"),
                    onChanged: (val) {
                      quizImageUrl = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter a name" : null,
                    decoration: InputDecoration(hintText: "Quiz Title"),
                    onChanged: (val) {
                      quizTitle = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter a description" : null,
                    decoration: InputDecoration(hintText: "Quiz Description"),
                    onChanged: (val) {
                      quizDescription = val;
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: blueButton(context: context, label: "New Quiz")),
                  SizedBox(
                    height: 60,
                  )
                ]),
              ),
            ),
    );
  }
}
