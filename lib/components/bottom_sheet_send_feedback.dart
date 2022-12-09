import 'package:email_validator/email_validator.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/feedback_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetSendFeedback extends StatefulWidget {
  const BottomSheetSendFeedback({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetSendFeedback> createState() =>
      _BottomSheetSendFeedbackState();
}

class _BottomSheetSendFeedbackState extends State<BottomSheetSendFeedback> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  RegExp specialRegex = RegExp("[~}^={+></|']+");
  RegExp specialRegex2 = RegExp("[!@#%&)*(,.;:?¿]+");
  // ignore: unnecessary_string_escapes
  RegExp tooSpecialRegex = RegExp("[\$\_\`\-]+");
  // ignore: unnecessary_string_escapes
  RegExp tooSpecialRegex2 = RegExp("[\[]+");
  // ignore: unnecessary_string_escapes
  RegExp tooSpecialRegex3 = RegExp("[\"]+");
  RegExp tooSpecialRegex4 = RegExp("]+");
  String tooSpecialRegex5 = r"\";
  RegExp digitRegex = RegExp("[0-9]+");
  RegExp lettersRegex = RegExp("[a-zA-Z]+");

  bool nameFieldOK = true;
  bool nameFieldTouched = false;
  bool emailFieldOK = true;
  bool emailFieldTouched = false;
  bool subjectFieldOK = true;
  bool subjectFieldTouched = false;
  bool bodyFieldOK = true;
  bool bodyFieldTouched = false;

  @override
  Widget build(BuildContext context) {
    List<String> dropdownList =
        Provider.of<ServicesProvider>(context).englishOption
            ? kDropdownButtonList
            : kEsDropdownButtonList;
    bool fieldsOK = Provider.of<FeedbackProvider>(context).bodyKeyword != '' &&
        (Provider.of<FeedbackProvider>(context).nameKeyword != '' &&
            nameFieldOK) &&
        (Provider.of<FeedbackProvider>(context).emailKeyword != '' &&
            emailFieldOK) &&
        (((Provider.of<FeedbackProvider>(context).subjectDropDownKeyword ==
                        kDropdownButtonList.last ||
                    Provider.of<FeedbackProvider>(context)
                            .subjectDropDownKeyword ==
                        kEsDropdownButtonList.last) &&
                Provider.of<FeedbackProvider>(context)
                        .subjectTextFieldKeyword !=
                    '' &&
                subjectFieldOK) ||
            (Provider.of<FeedbackProvider>(context).subjectDropDownKeyword !=
                    kDropdownButtonList.last &&
                Provider.of<FeedbackProvider>(context).subjectDropDownKeyword !=
                    kEsDropdownButtonList.last &&
                Provider.of<FeedbackProvider>(context).subjectDropDownKeyword !=
                    '' &&
                Provider.of<FeedbackProvider>(context)
                        .subjectTextFieldKeyword ==
                    ''));

    Color backgroundColor =
        Provider.of<ServicesProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;

    return Container(
      height: MediaQuery.of(context).size.height * kBottomSheetHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kBottomSheetBorderRadius),
          topRight: Radius.circular(kBottomSheetBorderRadius),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: kPaddingTopButton,
                left: kPaddingRightButton,
                right: kPaddingRightButton,
                bottom: kPaddingTopButton),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text(
                    isEnglish ? kBottomSheetCancel : kEsBottomSheetCancel,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () {
                    Provider.of<FeedbackProvider>(context, listen: false)
                        .clearFields();
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: kElevatedButtonWidth,
                  height: kElevatedButtonHeight,
                  child: ElevatedButton(
                    onPressed: fieldsOK
                        ? () async {
                            await Provider.of<FeedbackProvider>(context,
                                    listen: false)
                                .saveFeedbackData(
                                    backgroundColor, textColor, isEnglish)
                                .then((_) => Navigator.pop(context));
                          }
                        : null,
                    child: Provider.of<FeedbackProvider>(context).isWaiting
                        ? const SizedBox(
                            height: kCircularProgressIndicatorSquare,
                            width: kCircularProgressIndicatorSquare,
                            child: CircularProgressIndicator(
                              strokeWidth: kCircularProgressIndicatorStroke,
                              valueColor: AlwaysStoppedAnimation(darkWhite),
                            ),
                          )
                        : Text(
                            isEnglish ? kBottomSheetSend : kEsBottomSheetSend,
                            style: !fieldsOK &&
                                    Provider.of<ServicesProvider>(context)
                                        .darkThemeSelected
                                ? Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: darkDropdown,
                                    )
                                : Theme.of(context).textTheme.headline6,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                kBottomSheetFeedbackSizedBox,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kSpaceBetweenTextField, left: kSpaceLeftText),
                    child: Text(
                      isEnglish ? kBottomSheetName : kEsBottomSheetName,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kSpaceBetweenTextFieldMax),
                    child: TextField(
                      maxLength: 55,
                      style: Theme.of(context).textTheme.headline2,
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      onChanged: (value) {
                        setNameFieldTouched();
                        Provider.of<FeedbackProvider>(context, listen: false)
                            .saveNameKeyword(value);
                        if (digitRegex.hasMatch(value) ||
                            specialRegex.hasMatch(value) ||
                            specialRegex2.hasMatch(value) ||
                            tooSpecialRegex.hasMatch(value) ||
                            tooSpecialRegex2.hasMatch(value) ||
                            tooSpecialRegex3.hasMatch(value) ||
                            tooSpecialRegex4.hasMatch(value) ||
                            value.contains(tooSpecialRegex5)) {
                          setNameValidator(false);
                        } else {
                          setNameValidator(true);
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: kSearchBoxDimensions,
                        errorText: setNameFieldErrorText() == ''
                            ? null
                            : setNameFieldErrorText(),
                        hintText: isEnglish
                            ? kBottomSheetHintName
                            : kEsBottomSheetHintName,
                        hintStyle: Theme.of(context).textTheme.headline4,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        suffixIcon: IconButton(
                          icon: Provider.of<FeedbackProvider>(context)
                                      .nameKeyword !=
                                  ''
                              ? Icon(
                                  Icons.clear,
                                  size: kIconsSizes,
                                  color: Theme.of(context).primaryColor,
                                )
                              : const SizedBox.shrink(),
                          onPressed: () {
                            setNameValidator(true);
                            nameController.clear();
                            Provider.of<FeedbackProvider>(context,
                                    listen: false)
                                .clearNameKeyword();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kSpaceBetweenTextField, left: kSpaceLeftText),
                    child: Text(
                      isEnglish ? kBottomSheetEmail : kEsBottomSheetEmail,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kSpaceBetweenTextFieldMax),
                    child: TextField(
                      maxLength: 55,
                      style: Theme.of(context).textTheme.headline2,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setEmailFieldTouched();
                        Provider.of<FeedbackProvider>(context, listen: false)
                            .saveEmailKeyword(value);
                        setEmailValidator(EmailValidator.validate(
                            Provider.of<FeedbackProvider>(context,
                                    listen: false)
                                .emailKeyword));
                      },
                      decoration: InputDecoration(
                        contentPadding: kSearchBoxDimensions,
                        errorText: setEmailFieldErrorText() == ''
                            ? null
                            : setEmailFieldErrorText(),
                        hintText: isEnglish
                            ? kBottomSheetHintEmail
                            : kEsBottomSheetHintEmail,
                        hintStyle: Theme.of(context).textTheme.headline4,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        suffixIcon: IconButton(
                          icon: Provider.of<FeedbackProvider>(context)
                                      .emailKeyword !=
                                  ''
                              ? Icon(
                                  Icons.clear,
                                  size: kIconsSizes,
                                  color: Theme.of(context).primaryColor,
                                )
                              : const SizedBox.shrink(),
                          onPressed: () {
                            setEmailValidator(true);
                            emailController.clear();
                            Provider.of<FeedbackProvider>(context,
                                    listen: false)
                                .clearEmailKeyword();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kSpaceBetweenTextField, left: kSpaceLeftText),
                    child: Text(
                      isEnglish ? kBottomSheetSubject : kEsBottomSheetSubject,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kSpaceBetweenTextFieldMax),
                    child: DropdownButtonFormField<String>(
                      hint: Text(
                        isEnglish
                            ? kBottomSheetHintSubjectDropdown
                            : kEsBottomSheetHintSubjectDropdown,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      icon: Icon(
                        Icons.arrow_downward,
                        size: kIconsSizes,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: Theme.of(context).textTheme.headline2,
                      onChanged: (value) =>
                          Provider.of<FeedbackProvider>(context, listen: false)
                              .saveSubjectDropDownKeyword(value),
                      decoration: InputDecoration(
                        contentPadding: kSearchBoxDimensions,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Provider.of<ServicesProvider>(context)
                                      .darkThemeSelected
                                  ? darkDropdown
                                  : lightDropdown,
                              width: kBorderWidthDropdown),
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Provider.of<ServicesProvider>(context)
                                      .darkThemeSelected
                                  ? darkDropdown
                                  : lightDropdown,
                              width: kBorderWidthDropdown),
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      items: dropdownList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kSpaceBetweenTextFieldMax,
                        right: kSpaceBetweenTextFieldMax,
                        top: kSpaceBetweenTextFieldMin,
                        bottom: kSpaceBetweenTextFieldMax),
                    child: TextField(
                      enabled: Provider.of<FeedbackProvider>(context)
                                  .subjectDropDownKeyword ==
                              kDropdownButtonList.last ||
                          Provider.of<FeedbackProvider>(context)
                                  .subjectDropDownKeyword ==
                              kEsDropdownButtonList.last,
                      maxLength: 60,
                      style: Theme.of(context).textTheme.headline2,
                      controller: subjectController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setSubjectFieldTouched();
                        Provider.of<FeedbackProvider>(context, listen: false)
                            .saveSubjectTextFieldKeyword(value);
                        if (specialRegex.hasMatch(value) ||
                            tooSpecialRegex.hasMatch(value) ||
                            tooSpecialRegex2.hasMatch(value) ||
                            tooSpecialRegex3.hasMatch(value) ||
                            tooSpecialRegex4.hasMatch(value) ||
                            value.contains(tooSpecialRegex5)) {
                          setSubjectValidator(false);
                        } else {
                          setSubjectValidator(true);
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: kSearchBoxDimensions,
                        errorText: setSubjectFieldErrorText() == ''
                            ? null
                            : setSubjectFieldErrorText(),
                        hintText: Provider.of<FeedbackProvider>(context)
                                        .subjectDropDownKeyword !=
                                    kDropdownButtonList.last &&
                                Provider.of<FeedbackProvider>(context)
                                        .subjectDropDownKeyword !=
                                    kEsDropdownButtonList.last
                            ? isEnglish
                                ? kBottomSheetHintSubjectDisabledTextField
                                : kEsBottomSheetHintSubjectDisabledTextField
                            : isEnglish
                                ? kBottomSheetHintSubjectEnableTextField
                                : kEsBottomSheetHintSubjectEnableTextField,
                        hintStyle: Theme.of(context).textTheme.headline4,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        suffixIcon: IconButton(
                          icon: Provider.of<FeedbackProvider>(context)
                                      .subjectTextFieldKeyword !=
                                  ''
                              ? Icon(
                                  Icons.clear,
                                  size: kIconsSizes,
                                  color: Theme.of(context).primaryColor,
                                )
                              : const SizedBox.shrink(),
                          onPressed: () {
                            setSubjectValidator(true);
                            subjectController.clear();
                            Provider.of<FeedbackProvider>(context,
                                    listen: false)
                                .clearSubjectTextFieldKeyword();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kSpaceBetweenTextField,
                        bottom: kSpaceBetweenTextField,
                        left: kSpaceLeftText),
                    child: Text(
                      isEnglish ? kBottomSheetBody : kEsBottomSheetBody,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kSpaceBetweenTextFieldMax),
                    child: TextField(
                      maxLines: null,
                      maxLength: 250,
                      textAlignVertical: TextAlignVertical.top,
                      style: Theme.of(context).textTheme.headline2,
                      controller: bodyController,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setBodytFieldTouched();
                        Provider.of<FeedbackProvider>(context, listen: false)
                            .saveBodyKeyword(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: kSDescriptionBoxDimensions,
                        errorText: Provider.of<FeedbackProvider>(context)
                                        .bodyKeyword ==
                                    '' &&
                                bodyFieldTouched
                            ? isEnglish
                                ? kBottomSheetErrorFieldEmpty
                                : kEsBottomSheetErrorFieldEmpty
                            : null,
                        hintText: isEnglish
                            ? kBottomSheetHintBody
                            : kEsBottomSheetHintBody,
                        hintStyle: Theme.of(context).textTheme.headline4,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        suffixIcon: IconButton(
                          icon: Provider.of<FeedbackProvider>(context)
                                      .bodyKeyword !=
                                  ''
                              ? Icon(
                                  Icons.clear,
                                  size: kIconsSizes,
                                  color: Theme.of(context).primaryColor,
                                )
                              : const SizedBox.shrink(),
                          onPressed: () {
                            bodyController.clear();
                            Provider.of<FeedbackProvider>(context,
                                    listen: false)
                                .clearBodyKeyword();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setNameValidator(value) {
    setState(() {
      nameFieldOK = value;
    });
  }

  void setNameFieldTouched() {
    setState(() {
      nameFieldTouched = true;
    });
  }

  String setNameFieldErrorText() {
    if (nameFieldTouched &&
        !nameFieldOK &&
        Provider.of<FeedbackProvider>(context).nameKeyword != '') {
      return Provider.of<ServicesProvider>(context).englishOption
          ? kBottomSheetErrorWronFormat
          : kEsBottomSheetErrorWronFormat;
    }
    if (nameFieldTouched &&
        Provider.of<FeedbackProvider>(context).nameKeyword == '') {
      return Provider.of<ServicesProvider>(context).englishOption
          ? kBottomSheetErrorFieldEmpty
          : kEsBottomSheetErrorFieldEmpty;
    }
    return '';
  }

  void setEmailValidator(value) {
    setState(() {
      emailFieldOK = value;
    });
  }

  void setEmailFieldTouched() {
    setState(() {
      emailFieldTouched = true;
    });
  }

  String setEmailFieldErrorText() {
    if (emailFieldTouched &&
        !emailFieldOK &&
        Provider.of<FeedbackProvider>(context).emailKeyword != '') {
      return Provider.of<ServicesProvider>(context).englishOption
          ? kBottomSheetErrorEmailFormat
          : kEsBottomSheetErrorEmailFormat;
    }
    if (emailFieldTouched &&
        Provider.of<FeedbackProvider>(context).emailKeyword == '') {
      return Provider.of<ServicesProvider>(context).englishOption
          ? kBottomSheetErrorFieldEmpty
          : kEsBottomSheetErrorFieldEmpty;
    }
    return '';
  }

  void setSubjectValidator(value) {
    setState(() {
      subjectFieldOK = value;
    });
  }

  void setSubjectFieldTouched() {
    setState(() {
      subjectFieldTouched = true;
    });
  }

  String setSubjectFieldErrorText() {
    if (subjectFieldTouched &&
        !subjectFieldOK &&
        Provider.of<FeedbackProvider>(context).subjectTextFieldKeyword != '') {
      return Provider.of<ServicesProvider>(context).englishOption
          ? kBottomSheetErrorWronFormat
          : kEsBottomSheetErrorWronFormat;
    }
    if (subjectFieldTouched &&
        Provider.of<FeedbackProvider>(context).subjectTextFieldKeyword == '') {
      return Provider.of<ServicesProvider>(context).englishOption
          ? kBottomSheetErrorFieldEmpty
          : kEsBottomSheetErrorFieldEmpty;
    }
    if (Provider.of<FeedbackProvider>(context).subjectDropDownKeyword !=
            kDropdownButtonList.last &&
        Provider.of<FeedbackProvider>(context).subjectDropDownKeyword !=
            kEsDropdownButtonList.last) {
      setState(() {
        subjectFieldOK = true;
        subjectFieldTouched = false;
      });
      return '';
    }
    return '';
  }

  void setBodytFieldTouched() {
    setState(() {
      bodyFieldTouched = true;
    });
  }
}
