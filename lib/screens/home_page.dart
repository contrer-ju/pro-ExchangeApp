import 'package:the_exchange_app/components/ad_banner_container.dart';
import 'package:the_exchange_app/components/bottom_sheet_add_currencies_list.dart';
import 'package:the_exchange_app/components/bottom_sheet_delete_currencies_list.dart';
import 'package:the_exchange_app/components/dialog_amount.dart';
import 'package:the_exchange_app/components/dialog_exit.dart';
import 'package:the_exchange_app/components/list_tile_base_selected_currency.dart';
import 'package:the_exchange_app/components/drawer_menu.dart';
import 'package:the_exchange_app/components/tool_bar.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/services/countries_currencies_provider.dart';
import 'package:the_exchange_app/services/cripto_currencies_provider.dart';
import 'package:the_exchange_app/services/references_currencies_provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/theme_provider.dart';
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
      barrierDismissible: false,
      builder: (context) => DialogExit(context: context),
    );
    return exitResult ?? false;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SelectedCurrenciesProvider>(context, listen: false)
          .loadCurrenciesList();
      Provider.of<CountriesCurrenciesProvider>(context, listen: false)
          .loadCountryList();
      Provider.of<CriptoCurrenciesProvider>(context, listen: false)
          .loadCriptoList();
      Provider.of<ReferenceCurrenciesProvider>(context, listen: false)
          .loadReferenceList();
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
          drawer: const DrawerMenu(),
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
                      Provider.of<ThemeProvider>(context).englishOption
                          ? kNothingToUpdate
                          : kEsNothingToUpdate,
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
                                        if ((!selectedCurrenciesList[index]
                                                    .wasUpdated &&
                                                !selectedCurrenciesList[index]
                                                    .wasRead) ||
                                            selectedCurrenciesList[index]
                                                    .currencyRate ==
                                                0) {
                                          Provider.of<SelectedCurrenciesProvider>(
                                                  context,
                                                  listen: false)
                                              .showToastAlert(
                                                  Provider.of<ThemeProvider>(
                                                              context,
                                                              listen: false)
                                                          .englishOption
                                                      ? kMessagePleaseUpdate
                                                      : kEsMessagePleaseUpdate,
                                                  Provider.of<ThemeProvider>(
                                                              context,
                                                              listen: false)
                                                          .darkThemeSelected
                                                      ? darkYellow
                                                      : darkGreen,
                                                  Theme.of(context)
                                                      .scaffoldBackgroundColor);
                                        } else {
                                          Provider.of<SelectedCurrenciesProvider>(
                                                  context,
                                                  listen: false)
                                              .setBaseSelectedCurrency(
                                                  selectedCurrenciesList[index]
                                                      .imageID,
                                                  baseSelectedAmount *
                                                      selectedCurrenciesList[
                                                              index]
                                                          .currencyRate /
                                                      baseSelectedCurrency
                                                          .currencyRate);
                                        }
                                      },
                                      child: Image(
                                        width: kFlagImageWidth,
                                        height: kFlagImageHeight,
                                        image: AssetImage(
                                            'images/${selectedCurrenciesList[index].imageID}.png'),
                                      ),
                                    ),
                                    title: Text(
                                      Provider.of<ThemeProvider>(context)
                                              .englishOption
                                          ? selectedCurrenciesList[index]
                                              .currencyName
                                          : selectedCurrenciesList[index]
                                              .nombreMoneda,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    subtitle: Text(
                                      (!selectedCurrenciesList[index]
                                                      .wasUpdated &&
                                                  !selectedCurrenciesList[index]
                                                      .wasRead) ||
                                              selectedCurrenciesList[index]
                                                      .currencyRate ==
                                                  0
                                          ? Provider.of<ThemeProvider>(context)
                                                  .englishOption
                                              ? kUpdateRates
                                              : kEsUpdateRates
                                          : '1 ${baseSelectedCurrency.currencyISOCode.substring(0, 3) == 'rv_' ? 'VES' : baseSelectedCurrency.currencyISOCode.substring(0, 3) == 'ra_' ? 'ARS' : baseSelectedCurrency.currencyISOCode.toUpperCase()} = ${currencyRateFormat.format(selectedCurrenciesList[index].currencyRate / baseSelectedCurrency.currencyRate)} ${selectedCurrenciesList[index].currencyISOCode.substring(0, 3) == 'rv_' ? 'VES' : selectedCurrenciesList[index].currencyISOCode.substring(0, 3) == 'ra_' ? 'ARS' : selectedCurrenciesList[index].currencyISOCode.toUpperCase()}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if ((!selectedCurrenciesList[index]
                                                        .wasUpdated &&
                                                    !selectedCurrenciesList[
                                                            index]
                                                        .wasRead) ||
                                                selectedCurrenciesList[index]
                                                        .currencyRate ==
                                                    0) {
                                              Provider.of<SelectedCurrenciesProvider>(
                                                      context,
                                                      listen: false)
                                                  .showToastAlert(
                                                      Provider.of<ThemeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .englishOption
                                                          ? kMessagePleaseUpdate
                                                          : kEsMessagePleaseUpdate,
                                                      Provider.of<ThemeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkThemeSelected
                                                          ? darkYellow
                                                          : darkGreen,
                                                      Theme.of(context)
                                                          .scaffoldBackgroundColor);
                                            } else {
                                              Provider.of<SelectedCurrenciesProvider>(
                                                      context,
                                                      listen: false)
                                                  .setBaseSelectedCurrency(
                                                      selectedCurrenciesList[
                                                              index]
                                                          .imageID,
                                                      baseSelectedAmount *
                                                          selectedCurrenciesList[
                                                                  index]
                                                              .currencyRate /
                                                          baseSelectedCurrency
                                                              .currencyRate);
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (_) =>
                                                      const DialogAmount());
                                            }
                                          },
                                          child: Text(
                                            (!selectedCurrenciesList[index]
                                                            .wasUpdated &&
                                                        !selectedCurrenciesList[
                                                                index]
                                                            .wasRead) ||
                                                    selectedCurrenciesList[
                                                                index]
                                                            .currencyRate ==
                                                        0
                                                ? '${selectedCurrenciesList[index].currencyISOCode.substring(0, 3) == 'rv_' ? 'VES' : selectedCurrenciesList[index].currencyISOCode.substring(0, 3) == 'ra_' ? 'ARS' : selectedCurrenciesList[index].currencyISOCode.toUpperCase()} 0.00'
                                                : '${selectedCurrenciesList[index].currencyISOCode.substring(0, 3) == 'rv_' ? 'VES' : selectedCurrenciesList[index].currencyISOCode.substring(0, 3) == 'ra_' ? 'ARS' : selectedCurrenciesList[index].currencyISOCode.toUpperCase()} ${currencyAmountFormat.format(baseSelectedAmount * selectedCurrenciesList[index].currencyRate / baseSelectedCurrency.currencyRate)}',
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
