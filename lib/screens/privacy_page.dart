import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/components/sized_box_spaces.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEnglish ? kPrivTitle : kEsPrivTitle,
            style: appBarTitleTextStyle,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: kIconsSizes,
              color: darkWhite,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(kPaddingPage),
          children: <Widget>[
            Text(
              isEnglish ? kPrivPagePart1 : kEsPrivPagePart1,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
            const SecondarySpace(),
            Text(
              isEnglish ? kPrivPageSubTitle1 : kEsPrivPageSubTitle1,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
            Text(
              isEnglish ? kPrivPagePart2 : kEsPrivPagePart2,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
            const SecondarySpace(),
            Text(
              isEnglish ? kPrivPageSubTitle2 : kEsPrivPageSubTitle2,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
            Text(
              isEnglish ? kPrivPagePart3 : kEsPrivPagePart3,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
            const SecondarySpace(),
            Text(
              isEnglish ? kPrivPageSubTitle3 : kEsPrivPageSubTitle3,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
            Text(
              isEnglish ? kPrivPagePart4 : kEsPrivPagePart4,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
            const SecondarySpace(),
            Text(
              isEnglish ? kPrivPageSubTitle4 : kEsPrivPageSubTitle4,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
            Text(
              isEnglish ? kPrivPagePart5 : kEsPrivPagePart5,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
            const SecondarySpace(),
            Text(
              isEnglish ? kPrivPageSubTitle5 : kEsPrivPageSubTitle5,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
            Text(
              isEnglish ? kPrivPagePart6 : kEsPrivPagePart6,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
            const SecondarySpace(),
            Text(
              isEnglish ? kPrivPageSubTitle6 : kEsPrivPageSubTitle6,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
            Text(
              isEnglish ? kPrivPagePart7 : kEsPrivPagePart7,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
