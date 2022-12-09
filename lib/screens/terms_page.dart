import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/components/sized_box_spaces.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                isEnglish ? kTermsTitle : kEsTermsTitle,
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
                  isEnglish ? kTermsPageTitle1 : kEsTermsPageTitle1,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                Text(
                  isEnglish ? kTermsPageTitle2 : kEsTermsPageTitle2,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                const MainSpace(),
                Text(
                  isEnglish ? kTermsPagePart1 : kEsTermsPagePart1,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart2 : kEsTermsPagePart2,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle1 : kEsTermsPageSubtitle1,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart3 : kEsTermsPagePart3,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle2 : kEsTermsPageSubtitle2,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart4 : kEsTermsPagePart4,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart5 : kEsTermsPagePart5,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart6 : kEsTermsPagePart6,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle3 : kEsTermsPageSubtitle3,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart7 : kEsTermsPagePart7,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle4 : kEsTermsPageSubtitle4,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart8 : kEsTermsPagePart8,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart9 : kEsTermsPagePart9,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart10 : kEsTermsPagePart10,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart11 : kEsTermsPagePart11,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart12 : kEsTermsPagePart12,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle5 : kEsTermsPageSubtitle5,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart13 : kEsTermsPagePart13,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart14 : kEsTermsPagePart14,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart15 : kEsTermsPagePart15,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart16 : kEsTermsPagePart16,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart17 : kEsTermsPagePart17,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle6 : kEsTermsPageSubtitle6,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart18 : kEsTermsPagePart18,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle7 : kEsTermsPageSubtitle7,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart19 : kEsTermsPagePart19,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart20 : kEsTermsPagePart20,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle8 : kEsTermsPageSubtitle8,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart21 : kEsTermsPagePart21,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart22 : kEsTermsPagePart22,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPagePart23 : kEsTermsPagePart23,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
                const SecondarySpace(),
                Text(
                  isEnglish ? kTermsPageSubtitle9 : kEsTermsPageSubtitle9,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  isEnglish ? kTermsPagePart24 : kEsTermsPagePart24,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.justify,
                ),
              ],
            )));
  }
}
