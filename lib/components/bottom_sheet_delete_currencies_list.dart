import 'package:the_exchange_app/components/list_view_to_delete_currencies.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/countries_currencies_provider.dart';
import 'package:the_exchange_app/provider/cripto_currencies_provider.dart';
import 'package:the_exchange_app/provider/references_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetDeleteCurrenciesList extends StatelessWidget {
  BottomSheetDeleteCurrenciesList({
    Key? key,
  }) : super(key: key);

  final TextEditingController currencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
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
            child: Container(
              height: MediaQuery.of(context).size.height * kBottomSheetHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kBottomSheetBorderRadius),
                  topRight: Radius.circular(kBottomSheetBorderRadius),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingTopButton,
                        left: kPaddingRightButton,
                        right: kPaddingRightButton),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text(
                            kBottomSheetDelete,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () {
                            Provider.of<SelectedCurrenciesProvider>(context,
                                    listen: false)
                                .emptyCurrenciesList();
                            currencyController.clear();
                            Provider.of<CountriesCurrenciesProvider>(context,
                                    listen: false)
                                .clearCurrenciesSelected();
                            Provider.of<CriptoCurrenciesProvider>(context,
                                    listen: false)
                                .clearCurrenciesSelected();
                            Provider.of<ReferenceCurrenciesProvider>(context,
                                    listen: false)
                                .clearCurrenciesSelected();
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: Text(
                            kBottomSheetButton,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () {
                            currencyController.clear();
                            Provider.of<SelectedCurrenciesProvider>(context,
                                    listen: false)
                                .clearSelectedCurrenciesSearchList();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kPaddingRightButton),
                    child: TextField(
                      style: Theme.of(context).textTheme.headline2,
                      controller: currencyController,
                      onChanged: (value) =>
                          Provider.of<SelectedCurrenciesProvider>(context,
                                  listen: false)
                              .searchKeywordOnSelectedList(value),
                      decoration: InputDecoration(
                        hintText: kSearchBoxHint,
                        hintStyle: Theme.of(context).textTheme.headline4,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusSearchBox),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: kIconsSizes,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            currencyController.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                            Provider.of<SelectedCurrenciesProvider>(context,
                                    listen: false)
                                .clearSelectedCurrenciesSearchList();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        kBottomSheetSizedBox,
                    child: const DeleteSelectedCurrencyListView(),
                  )
                ],
              ),
            ),
          ),
        );
      },
      backgroundColor: Provider.of<ThemeProvider>(context).darkThemeSelected
          ? darkYellow
          : darkGreen,
      child: Icon(
        Icons.remove,
        size: kIconsSizes,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
