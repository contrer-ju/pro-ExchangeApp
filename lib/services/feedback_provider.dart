import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/style/theme.dart';

class FeedbackProvider extends ChangeNotifier {
  bool isWaiting = false;
  String nameKeyword = '';
  String emailKeyword = '';
  String subjectDropDownKeyword = '';
  String subjectTextFieldKeyword = '';
  String bodyKeyword = '';

  void saveNameKeyword(keyword) {
    nameKeyword = keyword;
    notifyListeners();
  }

  void saveEmailKeyword(keyword) {
    emailKeyword = keyword;
    notifyListeners();
  }

  void saveSubjectDropDownKeyword(keyword) {
    subjectDropDownKeyword = keyword;
    notifyListeners();
  }

  void saveSubjectTextFieldKeyword(keyword) {
    subjectTextFieldKeyword = keyword;
    notifyListeners();
  }

  void saveBodyKeyword(keyword) {
    bodyKeyword = keyword;
    notifyListeners();
  }

  void clearNameKeyword() {
    nameKeyword = '';
    notifyListeners();
  }

  void clearEmailKeyword() {
    emailKeyword = '';
    notifyListeners();
  }

  void clearSubjectTextFieldKeyword() {
    subjectTextFieldKeyword = '';
    notifyListeners();
  }

  void clearBodyKeyword() {
    bodyKeyword = '';
    notifyListeners();
  }

  void clearFields() {
    nameKeyword = '';
    emailKeyword = '';
    subjectDropDownKeyword = '';
    subjectTextFieldKeyword = '';
    bodyKeyword = '';
    notifyListeners();
  }

  Future<PingData> pingFunction() async {
    final ping = Ping('google.com', count: 5);
    return await ping.stream.last;
  }

  Future<bool> connectionTest() async {
    var pingResult = await pingFunction();
    if (pingResult.toString().contains("received:0") ||
        pingResult.toString().contains("PingError")) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> pushFeedbackData(String name, String email, String subject,
      String body, String date) async {
    bool wasPush = true;
    CollectionReference feedbackCollection =
        FirebaseFirestore.instance.collection("feedback");
    await feedbackCollection.doc(date).set({
      'name': name,
      'email': email,
      'subject': subject,
      'body': body,
      'date': date,
    }).onError((e, _) => wasPush = false);
    if (wasPush) {
      await feedbackCollection.doc('mail').update({
        'delivery.state': 'RETRY',
        'message.text': 'El id del mensaje es: $date',
      });
    }
    return wasPush;
  }

  Future<void> saveFeedbackData(
      Color bColor, Color tColor, bool isEnglish) async {
    isWaiting = true;
    notifyListeners();
    bool wasPush = false;
    bool hasConnection = await connectionTest();
    if (hasConnection) {
      final now = DateTime.now();
      String date =
          "${now.year}-${now.month}-${now.day}_${now.hour}:${now.minute}:${now.second}";
      String subject = subjectDropDownKeyword == kEsDropdownButtonList.last ||
              subjectDropDownKeyword == kDropdownButtonList.last
          ? '$subjectDropDownKeyword: $subjectTextFieldKeyword'
          : subjectDropDownKeyword;
      wasPush = await pushFeedbackData(
          nameKeyword, emailKeyword, subject, bodyKeyword, date);
    }
    clearFields();

    if (hasConnection) {
      if (wasPush) {
        showToastAlert(
            isEnglish ? kMessagePushTrue : kEsMessagePushTrue, bColor, tColor);
      } else {
        showToastAlert(
            isEnglish ? kMessagePushFail : kEsMessagePushFail, bColor, tColor);
      }
    } else {
      showToastAlert(
          isEnglish ? kMessageNotConex : kEsMessageNotConex, bColor, tColor);
    }
    isWaiting = false;
    notifyListeners();
  }

  void showToastAlert(String message, Color bColor, Color tColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: bColor,
        textColor: tColor,
        fontSize: kToastText);
  }
}
