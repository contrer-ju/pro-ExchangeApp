import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';

class UpdateIcon extends StatelessWidget {
  const UpdateIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        Provider.of<ServicesProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;

    return IconButton(
      key: Provider.of<ServicesProvider>(context).keyUpdateButton,
      icon: Provider.of<SelectedCurrenciesProvider>(context).isUpdating
          ? const SizedBox(
              height: kCircularProgressIndicatorSquare2,
              width: kCircularProgressIndicatorSquare2,
              child: CircularProgressIndicator(
                strokeWidth: kCircularProgressIndicatorStroke,
                valueColor: AlwaysStoppedAnimation(darkWhite),
              ),
            )
          : FaIcon(
              FontAwesomeIcons.rotate,
              size: kFaIconsSizes,
              color: Provider.of<SelectedCurrenciesProvider>(context)
                          .baseSelectedCurrency
                          .currencyName ==
                      ''
                  ? lightGrey
                  : darkWhite,
            ),
      onPressed: () {
        if (!Provider.of<SelectedCurrenciesProvider>(context, listen: false)
            .isUpdating) {
          Provider.of<SelectedCurrenciesProvider>(context, listen: false)
              .setTrueIsUpdating();
          Provider.of<SelectedCurrenciesProvider>(context, listen: false)
              .updateRatesCurrenciesList(backgroundColor, textColor, isEnglish);
        }
      },
    );
  }
}
