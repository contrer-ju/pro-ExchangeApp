import 'package:provider/provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';

class UpdateIcon extends StatelessWidget {
  const UpdateIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        Provider.of<ThemeProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;

    return IconButton(
      icon: Icon(
        Provider.of<SelectedCurrenciesProvider>(context).isUpdating
            ? Icons.lock_clock
            : Icons.restore,
        size: kIconsSizes,
        color: darkWhite,
      ),
      onPressed: () {
        Provider.of<SelectedCurrenciesProvider>(context, listen: false)
            .setTrueIsUpdating();
        Provider.of<SelectedCurrenciesProvider>(context, listen: false)
            .updateRatesCurrenciesList(backgroundColor, textColor);
      },
    );
  }
}
