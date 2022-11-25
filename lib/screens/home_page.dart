import 'package:the_exchange_app/components/ad_banner_container.dart';
import 'package:the_exchange_app/components/bottom_sheet_add_currencies_list.dart';
import 'package:the_exchange_app/components/bottom_sheet_delete_currencies_list.dart';
import 'package:the_exchange_app/components/dialog_amount.dart';
import 'package:the_exchange_app/components/dialog_exit.dart';
import 'package:the_exchange_app/components/list_tile_base_selected_currency.dart';
import 'package:the_exchange_app/components/menu.dart';
import 'package:the_exchange_app/components/tool_bar.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/provider/countries_currencies_provider.dart';
import 'package:the_exchange_app/provider/cripto_currencies_provider.dart';
import 'package:the_exchange_app/provider/currencies_rates_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currencyAmountFormat = NumberFormat("#,##0.00", "en_US");
  final currencyRateFormat = NumberFormat("#,##0.000", "en_US");

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => DialogExit(context: context),
    );
    return exitResult ?? false;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Color backgroundColor =
          Provider.of<ThemeProvider>(context, listen: false).darkThemeSelected
              ? darkYellow
              : darkGreen;
      Color textColor = Theme.of(context).scaffoldBackgroundColor;
      Provider.of<CurrenciesRatesProvider>(context, listen: false)
          .getCurrenciesRates(backgroundColor, textColor);
      Provider.of<SelectedCurrenciesProvider>(context, listen: false)
          .loadCurrenciesList();
      Provider.of<CountriesCurrenciesProvider>(context, listen: false)
          .loadCountryList();
      Provider.of<CriptoCurrenciesProvider>(context, listen: false)
          .loadCriptoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool loadingSelectedCurrenciesList =
        Provider.of<SelectedCurrenciesProvider>(context).isWaiting;
    bool loadingSelectedCountriesList =
        Provider.of<CountriesCurrenciesProvider>(context).isWaiting;
    bool loadingSelectedCriptoList =
        Provider.of<CriptoCurrenciesProvider>(context).isWaiting;
    double baseSelectedAmount = Provider.of<SelectedCurrenciesProvider>(context)
        .baseSelectedCurrencyAmount;
    SelectedCurrencies baseSelectedCurrency =
        Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency;
    List<SelectedCurrencies> selectedCurrenciesList =
        Provider.of<SelectedCurrenciesProvider>(context).selectedCurrenciesList;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: SafeArea(
        child: Scaffold(
          appBar: const ToolBar(),
          drawer: const Menu(),
          body: loadingSelectedCurrenciesList ||
                  loadingSelectedCountriesList ||
                  loadingSelectedCriptoList
              ? Center(
                  child: SizedBox(
                  height: kSquareCircularProgressIndicator,
                  width: kSquareCircularProgressIndicator,
                  child: CircularProgressIndicator(
                    strokeWidth: kStrokeCircularProgressIndicator,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                ))
              : selectedCurrenciesList.isEmpty &&
                      baseSelectedCurrency.currencyName == ""
                  ? Center(
                      child: Text(
                      kNothingToUpdate,
                      style: Theme.of(context).textTheme.headline5,
                    ))
                  : Column(
                      children: [
                        BaseSelectedCurrencyListTile(),
                        Expanded(
                            child: Theme(
                          data: ThemeData(canvasColor: transparentColor),
                          child: ReorderableListView(
                            buildDefaultDragHandles: false,
                            children: <Widget>[
                              for (int index = 0;
                                  index < selectedCurrenciesList.length;
                                  index++)
                                Card(
                                  key: Key('$index'),
                                  elevation: kElevationCurrencyCard,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kMainCardBorderRadius),
                                      borderSide: const BorderSide(
                                          color: darkWhite,
                                          width: kMainCardBorderWidth)),
                                  child: ListTile(
                                    leading: GestureDetector(
                                      onTap: () {
                                        Provider.of<SelectedCurrenciesProvider>(context, listen: false).setBaseSelectedCurrency(
                                            selectedCurrenciesList[index]
                                                .imageID,
                                            baseSelectedAmount *
                                                Provider.of<CurrenciesRatesProvider>(context, listen: false)
                                                    .currenciesRatesList[Provider.of<CurrenciesRatesProvider>(context, listen: false)
                                                        .currenciesRatesList
                                                        .indexWhere((item) =>
                                                            item.currencyISOCode ==
                                                            selectedCurrenciesList[index]
                                                                .currencyISOCode)]
                                                    .currencyRate /
                                                Provider.of<CurrenciesRatesProvider>(
                                                        context,
                                                        listen: false)
                                                    .currenciesRatesList[
                                                        Provider.of<CurrenciesRatesProvider>(
                                                                context,
                                                                listen: false)
                                                            .currenciesRatesList
                                                            .indexWhere((item) => item.currencyISOCode == baseSelectedCurrency.currencyISOCode)]
                                                    .currencyRate);
                                      },
                                      child: Image(
                                        width: kFlagImageWidth,
                                        height: kFlagImageHeight,
                                        image: AssetImage(
                                            'images/${selectedCurrenciesList[index].imageID}.png'),
                                      ),
                                    ),
                                    title: Text(
                                      selectedCurrenciesList[index]
                                          .currencyName,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    subtitle: Text(
                                      Provider.of<CurrenciesRatesProvider>(
                                                      context)
                                                  .ratesUpdated ||
                                              Provider.of<CurrenciesRatesProvider>(
                                                      context)
                                                  .ratesRead
                                          ? '1 ${baseSelectedCurrency.currencyISOCode.toUpperCase()} = ${currencyRateFormat.format(Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList[Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList.indexWhere((item) => item.currencyISOCode == selectedCurrenciesList[index].currencyISOCode)].currencyRate / Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList[Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList.indexWhere((item) => item.currencyISOCode == baseSelectedCurrency.currencyISOCode)].currencyRate)} ${selectedCurrenciesList[index].currencyISOCode.toUpperCase()}'
                                          : kUpdateRates,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (Provider.of<CurrenciesRatesProvider>(
                                                        context,
                                                        listen: false)
                                                    .ratesUpdated ||
                                                Provider.of<CurrenciesRatesProvider>(
                                                        context,
                                                        listen: false)
                                                    .ratesRead) {
                                              Provider.of<SelectedCurrenciesProvider>(context, listen: false).setBaseSelectedCurrency(
                                                  selectedCurrenciesList[index]
                                                      .imageID,
                                                  baseSelectedAmount *
                                                      Provider.of<CurrenciesRatesProvider>(context, listen: false)
                                                          .currenciesRatesList[Provider.of<CurrenciesRatesProvider>(context,
                                                                  listen: false)
                                                              .currenciesRatesList
                                                              .indexWhere((item) =>
                                                                  item.currencyISOCode ==
                                                                  selectedCurrenciesList[index]
                                                                      .currencyISOCode)]
                                                          .currencyRate /
                                                      Provider.of<CurrenciesRatesProvider>(context,
                                                              listen: false)
                                                          .currenciesRatesList[
                                                              Provider.of<CurrenciesRatesProvider>(context, listen: false)
                                                                  .currenciesRatesList
                                                                  .indexWhere((item) => item.currencyISOCode == baseSelectedCurrency.currencyISOCode)]
                                                          .currencyRate);
                                              showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      const DialogAmount());
                                            } else {
                                              Provider.of<CurrenciesRatesProvider>(
                                                      context,
                                                      listen: false)
                                                  .showToastAlert(
                                                      kMessagePleaseUpdate,
                                                      Provider.of<ThemeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkThemeSelected
                                                          ? darkYellow
                                                          : darkGreen,
                                                      Theme.of(context)
                                                          .scaffoldBackgroundColor);
                                            }
                                          },
                                          child: Text(
                                            '${selectedCurrenciesList[index].currencyISOCode.toUpperCase()} ${currencyAmountFormat.format(baseSelectedAmount * Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList[Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList.indexWhere((item) => item.currencyISOCode == selectedCurrenciesList[index].currencyISOCode)].currencyRate / Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList[Provider.of<CurrenciesRatesProvider>(context).currenciesRatesList.indexWhere((item) => item.currencyISOCode == baseSelectedCurrency.currencyISOCode)].currencyRate)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: kPaddingLeftReorderableDrag,
                                              right:
                                                  kPaddingRightReorderableDrag),
                                          child: ReorderableDragStartListener(
                                            index: index,
                                            child: Icon(
                                              Icons.unfold_more_rounded,
                                              size: kIconsSizes,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                            onReorder: (int oldIndex, int newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final SelectedCurrencies removedCurrency =
                                    selectedCurrenciesList.removeAt(oldIndex);
                                selectedCurrenciesList.insert(
                                    newIndex, removedCurrency);
                              });
                              Provider.of<SelectedCurrenciesProvider>(context,
                                      listen: false)
                                  .onReorderSelectedCurrenciesList(
                                      selectedCurrenciesList);
                            },
                          ),
                        ))
                      ],
                    ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BottomSheetAddCurrenciesList(),
              const SizedBox(
                height: kSpaceBetweenButtons,
              ),
              BottomSheetDeleteCurrenciesList(),
            ],
          ),
          bottomNavigationBar: const AdBannerContainer(),
        ),
      ),
    );
  }
}
