import 'package:the_exchange_app/services/references_currencies_provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferenceCurrencyListTile extends StatelessWidget {
  final String referenceName;
  final String nombreReferencia;
  final String referenceID;
  final String country;
  final String pais;
  final bool isChecked;

  const ReferenceCurrencyListTile({
    Key? key,
    required this.referenceName,
    required this.nombreReferencia,
    required this.referenceID,
    required this.country,
    required this.pais,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kElevationCurrencyCard,
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kMainCardBorderRadius),
          borderSide:
              const BorderSide(color: darkWhite, width: kMainCardBorderWidth)),
      child: ListTile(
        leading: Image(
          width: kFlagImageWidth,
          height: kFlagImageHeight,
          image: AssetImage('images/$referenceID.png'),
        ),
        title: Text(
          Provider.of<ServicesProvider>(context).englishOption
              ? referenceName
              : nombreReferencia,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          Provider.of<ServicesProvider>(context).englishOption ? country : pais,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing: Checkbox(
          activeColor: Theme.of(context).scaffoldBackgroundColor,
          checkColor: Theme.of(context).primaryColor,
          value: isChecked,
          onChanged: (bool? value) {
            Provider.of<ReferenceCurrenciesProvider>(context, listen: false)
                .toggleCheckboxOfCurrency(referenceID);
            if (isChecked) {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .deletedCurrencyFromList(referenceID);
            } else {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .addCurrencyToList(referenceID, referenceName,
                      nombreReferencia, referenceID);
            }
          },
        ),
      ),
    );
  }
}
