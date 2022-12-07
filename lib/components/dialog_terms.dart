import 'package:flutter/gestures.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';

class DialogTerms extends StatelessWidget {
  const DialogTerms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle hyperlink = Theme.of(context).textTheme.headline3!.copyWith(
        decoration: TextDecoration.underline, fontWeight: FontWeight.w300);
    bool isEnglish = Provider.of<ThemeProvider>(context).englishOption;
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        kAppTitle,
        style: Theme.of(context).textTheme.headline1,
      ),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: isEnglish ? kTerms1 : kEsTerms1,
          style: Theme.of(context).textTheme.headline3,
          children: <TextSpan>[
            TextSpan(
              text: isEnglish ? kTerms2 : kEsTerms2,
              style: hyperlink,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(text: isEnglish ? kTerms3 : kEsTerms3),
            TextSpan(
              text: isEnglish ? kTerms4 : kEsTerms4,
              style: hyperlink,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(text: isEnglish ? kTerms5 : kEsTerms5),
            TextSpan(
              text: isEnglish ? kTerms6 : kEsTerms6,
              style: hyperlink,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(text: isEnglish ? kTerms7 : kEsTerms7),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kAcceptButton
                  : kEsAcceptButton,
              style: Theme.of(context).textTheme.headline2,
            ))
      ],
    );
  }
}
