import 'package:flutter/gestures.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';

class DialogTerms extends StatelessWidget {
  const DialogTerms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle hyperlink = Theme.of(context).textTheme.headline3!.copyWith(
        decoration: TextDecoration.underline, fontWeight: FontWeight.w300);
    Color backgroundColor =
        Provider.of<ServicesProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
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
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, '/terms'),
              ),
              TextSpan(text: isEnglish ? kTerms3 : kEsTerms3),
              TextSpan(
                text: isEnglish ? kTerms4 : kEsTerms4,
                style: hyperlink,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, '/priv'),
              ),
              TextSpan(text: isEnglish ? kTerms5 : kEsTerms5),
              TextSpan(
                text: isEnglish ? kTerms6 : kEsTerms6,
                style: hyperlink,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pop();
                    Provider.of<SelectedCurrenciesProvider>(context,
                            listen: false)
                        .readLicense(backgroundColor, textColor, isEnglish);
                  },
              ),
              TextSpan(text: isEnglish ? kTerms7 : kEsTerms7),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Provider.of<SelectedCurrenciesProvider>(context,
                          listen: false)
                      .readLicense(backgroundColor, textColor, isEnglish);
                },
                child: const Image(
                  width: kLicenseImageWidth,
                  height: kLicenseImageHeight,
                  image: AssetImage('images/license.png'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? kAcceptButton
                        : kEsAcceptButton,
                    style: Theme.of(context).textTheme.headline6,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
