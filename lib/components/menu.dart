import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  ? Icons.nightlight
                  : Icons.sunny,
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
              Icons.language,
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
        ],
      ),
    );
  }
}
