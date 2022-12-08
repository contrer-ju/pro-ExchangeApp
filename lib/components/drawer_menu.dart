import 'package:share_plus/share_plus.dart';
import 'package:the_exchange_app/components/bottom_sheet_send_feedback.dart';
import 'package:the_exchange_app/components/dialog_terms.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        Provider.of<ThemeProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    bool isEnglish = Provider.of<ThemeProvider>(context).englishOption;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width * kDrawerWidth,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.21,
                    child: Image.asset('images/logo.png')),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  kAppTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Provider.of<ThemeProvider>(context).darkThemeSelected
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).darkThemeSelected
                  ? Provider.of<ThemeProvider>(context).englishOption
                      ? kDarkThemeOption
                      : kEsDarkThemeOption
                  : Provider.of<ThemeProvider>(context).englishOption
                      ? kLightThemeOption
                      : kEsLightThemeOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).switchTheme();
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.translate_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kEnglishOption
                  : kSpanishOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .switchLanguage();
              Scaffold.of(context).closeDrawer();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.thumb_up_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kRateAppOption
                  : kEsRateAppOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () async {
              Scaffold.of(context).closeDrawer();
              await Provider.of<SelectedCurrenciesProvider>(context,
                      listen: false)
                  .rateApp(backgroundColor, textColor, isEnglish);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kShareOption
                  : kEsShareOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              _onShare(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.feedback_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kFeedbackOption
                  : kEsFeedbackOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                enableDrag: false,
                isDismissible: false,
                backgroundColor: transparentColor,
                builder: (context) => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: const BottomSheetSendFeedback(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kPrivacyOption
                  : kEsPrivacyOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const DialogTerms());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ThemeProvider>(context).englishOption
                  ? kHelpOption
                  : kEsHelpOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
            },
          ),
        ],
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        Provider.of<ThemeProvider>(context, listen: false).englishOption
            ? kShareMessage
            : kEsShareMessage,
        subject:
            Provider.of<ThemeProvider>(context, listen: false).englishOption
                ? kShareTitle
                : kEsShareTitle,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
