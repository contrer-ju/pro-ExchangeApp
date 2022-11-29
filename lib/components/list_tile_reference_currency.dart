import 'package:the_exchange_app/provider/references_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferenceCurrencyListTile extends StatelessWidget {
  final String referenceName;
  final String referenceID;
  final String country;
  final bool isChecked;

  const ReferenceCurrencyListTile({
    Key? key,
    required this.referenceName,
    required this.referenceID,
    required this.country,
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
          referenceName,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          country,
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
                  .addCurrencyToList(referenceID, referenceName, referenceID);
            }
          },
        ),
      ),
    );
  }
}
