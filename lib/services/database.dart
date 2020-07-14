import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizID) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }
}
