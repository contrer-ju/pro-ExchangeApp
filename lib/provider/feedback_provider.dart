import 'package:flutter/foundation.dart';

class FeedbackProvider extends ChangeNotifier {
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
}
