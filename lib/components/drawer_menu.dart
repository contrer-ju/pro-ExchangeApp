import 'package:advance_expansion_tile/advance_expansion_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_exchange_app/components/bottom_sheet_send_feedback.dart';
import 'package:the_exchange_app/components/dialog_terms.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool themeTileExpanded = false;
  bool languageTileExpanded = false;

  final GlobalKey<AdvanceExpansionTileState> themeKey = GlobalKey();
  final GlobalKey<AdvanceExpansionTileState> languageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        Provider.of<ServicesProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;

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
          AdvanceExpansionTile(
            key: themeKey,
            leading: FaIcon(
              FontAwesomeIcons.circleHalfStroke,
              size: kFaIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ServicesProvider>(context).englishOption
                  ? kThemeOption
                  : kEsThemeOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            trailing: FaIcon(
              themeTileExpanded
                  ? FontAwesomeIcons.chevronUp
                  : FontAwesomeIcons.chevronDown,
              size: kFaIconsSizeSmall,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (themeTileExpanded) {
                themeKey.currentState?.collapse();
                setState(() {
                  themeTileExpanded = false;
                });
              } else {
                languageKey.currentState?.collapse();
                themeKey.currentState?.expand();
                setState(() {
                  languageTileExpanded = false;
                  themeTileExpanded = true;
                });
              }
            },
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: kLeftPaddig),
                child: ListTile(
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    size: kIconsSizeSmall,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? kDarkThemeOption
                        : kEsDarkThemeOption,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  trailing:
                      Provider.of<ServicesProvider>(context).darkThemeSelected
                          ? Icon(Icons.check,
                              size: kIconsSizeSmall,
                              color: Theme.of(context).primaryColor)
                          : const SizedBox.shrink(),
                  onTap: () {
                    Provider.of<ServicesProvider>(context, listen: false)
                        .setDarkTheme();
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kLeftPaddig),
                child: ListTile(
                  leading: Icon(
                    Icons.light_mode_outlined,
                    size: kIconsSizeSmall,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? kLightThemeOption
                        : kEsLightThemeOption,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  trailing:
                      Provider.of<ServicesProvider>(context).darkThemeSelected
                          ? const SizedBox.shrink()
                          : Icon(Icons.check,
                              size: kIconsSizeSmall,
                              color: Theme.of(context).primaryColor),
                  onTap: () {
                    Provider.of<ServicesProvider>(context, listen: false)
                        .setLightTheme();
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ),
            ],
          ),
          AdvanceExpansionTile(
            key: languageKey,
            leading: Icon(
              Icons.translate_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ServicesProvider>(context).englishOption
                  ? kLanguageOption
                  : kEsLanguageOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            trailing: FaIcon(
              languageTileExpanded
                  ? FontAwesomeIcons.chevronUp
                  : FontAwesomeIcons.chevronDown,
              size: kFaIconsSizeSmall,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (languageTileExpanded) {
                languageKey.currentState?.collapse();
                setState(() {
                  languageTileExpanded = false;
                });
              } else {
                themeKey.currentState?.collapse();
                languageKey.currentState?.expand();
                setState(() {
                  themeTileExpanded = false;
                  languageTileExpanded = true;
                });
              }
            },
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: kLeftPaddig),
                child: ListTile(
                  leading: FaIcon(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? FontAwesomeIcons.s
                        : FontAwesomeIcons.e,
                    size: kFaIconsSizeSmall,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? kSpanishLanguage
                        : kEsSpanishLanguage,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  trailing: Provider.of<ServicesProvider>(context).englishOption
                      ? const SizedBox.shrink()
                      : Icon(Icons.check,
                          size: kIconsSizeSmall,
                          color: Theme.of(context).primaryColor),
                  onTap: () {
                    Provider.of<ServicesProvider>(context, listen: false)
                        .setSpanish();
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kLeftPaddig),
                child: ListTile(
                  leading: FaIcon(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? FontAwesomeIcons.e
                        : FontAwesomeIcons.i,
                    size: kFaIconsSizeSmall,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    Provider.of<ServicesProvider>(context).englishOption
                        ? kEnglishLanguage
                        : kEsEnglishLanguage,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  trailing: Provider.of<ServicesProvider>(context).englishOption
                      ? Icon(Icons.check,
                          size: kIconsSizeSmall,
                          color: Theme.of(context).primaryColor)
                      : const SizedBox.shrink(),
                  onTap: () {
                    Provider.of<ServicesProvider>(context, listen: false)
                        .setEnglish();
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.thumb_up_outlined,
              size: kIconsSizes,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              Provider.of<ServicesProvider>(context).englishOption
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
              Provider.of<ServicesProvider>(context).englishOption
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
              Provider.of<ServicesProvider>(context).englishOption
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
              Provider.of<ServicesProvider>(context).englishOption
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
              Provider.of<ServicesProvider>(context).englishOption
                  ? kHelpOption
                  : kEsHelpOption,
              style: Theme.of(context).textTheme.headline2,
            ),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Provider.of<ServicesProvider>(context, listen: false)
                  .checkCurrenciesList(
                      Provider.of<SelectedCurrenciesProvider>(context,
                                  listen: false)
                              .baseSelectedCurrency
                              .currencyName !=
                          '',
                      Provider.of<SelectedCurrenciesProvider>(context,
                              listen: false)
                          .selectedCurrenciesList
                          .isNotEmpty);
              Provider.of<ServicesProvider>(context, listen: false)
                  .tutorialCoachMark
                  .show(context: context);
            },
          ),
        ],
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        Provider.of<ServicesProvider>(context, listen: false).englishOption
            ? kShareMessage
            : kEsShareMessage,
        subject:
            Provider.of<ServicesProvider>(context, listen: false).englishOption
                ? kShareTitle
                : kEsShareTitle,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
