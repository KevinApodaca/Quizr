import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/quiz_play_widget.dart';
import 'package:quizmaker/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizID;
  PlayQuiz(this.quizID);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

Stream infostream;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["Choice A"],
      questionSnapshot.data["Choice B"],
      questionSnapshot.data["Choice C"],
      questionSnapshot.data["Choice D"]
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option1 = options[1];
    questionModel.option1 = options[2];
    questionModel.option1 = options[3];
    questionModel.correctOption = questionSnapshot.data["Choice A"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizID}");
    databaseService.getQuizData(widget.quizID).then((value) {
      questionSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot.documents.length;

      print("$total the total");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            questionSnapshot == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionSnapshot.documents.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDatasnapshot(
                            questionSnapshot.documents[index]),
                        index: index,
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(widget.questionModel.question),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct answer
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctOption) {
                // ignore: unnecessary_statements
                optionSelected == widget.questionModel.option1;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option1,
            option: "A",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct answer
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctOption) {
                // ignore: unnecessary_statements
                optionSelected == widget.questionModel.option2;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option2,
            option: "B",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct answer
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctOption) {
                // ignore: unnecessary_statements
                optionSelected == widget.questionModel.option3;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option3,
            option: "C",
            optionSelected: optionSelected,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            if (!widget.questionModel.answered) {
              ///correct answer
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctOption) {
                // ignore: unnecessary_statements
                optionSelected == widget.questionModel.option4;
                widget.questionModel.answered = true;
                _correct = _correct + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                _incorrect = _incorrect + 1;
                _notAttempted = _notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: OptionTile(
            correctAnswer: widget.questionModel.option1,
            description: widget.questionModel.option4,
            option: "D",
            optionSelected: optionSelected,
          ),
        ),
      ]),
    );
  }
}
