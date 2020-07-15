import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizID;
  AddQuestion(this.quizID);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, choice1, choice2, choice3, choice4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = false;
      });
      Map<String, String> questionMap = {
        "Question": question,
        "Choice A": choice1,
        "Choice B": choice2,
        "Choice C": choice3,
        "Choice D": choice4
      };
      await databaseService
          .addQuestionData(questionMap, widget.quizID)
          .then((value) {
        setState(() {
          _isLoading = false;
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
                    validator: (val) => val.isEmpty ? "Missing question" : null,
                    decoration: InputDecoration(hintText: "Question"),
                    onChanged: (val) {
                      question = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Missing choice" : null,
                    decoration:
                        InputDecoration(hintText: "Choice A (correct answer)"),
                    onChanged: (val) {
                      choice1 = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Missing choice" : null,
                    decoration: InputDecoration(hintText: "Choice B"),
                    onChanged: (val) {
                      choice2 = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Missing choice" : null,
                    decoration: InputDecoration(hintText: "Choice C"),
                    onChanged: (val) {
                      choice3 = val;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "Missing choice" : null,
                    decoration: InputDecoration(hintText: "Choice D"),
                    onChanged: (val) {
                      choice4 = val;
                    },
                  ),
                  Spacer(),
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: blueButton(
                          context: context,
                          label: "Submit",
                          buttonWidth:
                              MediaQuery.of(context).size.width / 2 - 36),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadQuestionData();
                      },
                      child: blueButton(
                          context: context,
                          label: "Add Question",
                          buttonWidth:
                              MediaQuery.of(context).size.width / 2 - 36),
                    ),
                  ]),
                  SizedBox(
                    height: 60,
                  ),
                ]),
              ),
            ),
    );
  }
}
