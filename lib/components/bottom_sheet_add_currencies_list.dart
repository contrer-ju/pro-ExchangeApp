import 'package:the_exchange_app/components/list_view_country_currency.dart';
import 'package:the_exchange_app/components/list_view_cripto_currency.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/countries_currencies_provider.dart';
import 'package:the_exchange_app/provider/cripto_currencies_provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetAddCurrenciesList extends StatelessWidget {
  BottomSheetAddCurrenciesList({
    Key? key,
  }) : super(key: key);

  final TextEditingController currencyController = TextEditingController();
  final TextEditingController criptoController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingTopButton, right: kPaddingRightButton),
                    child: ElevatedButton(
                      child: Text(
                        kBottomSheetButton,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      onPressed: () {
                        currencyController.clear();
                        criptoController.clear();
                        referenceController.clear();
                        Provider.of<CountriesCurrenciesProvider>(context,
                                listen: false)
                            .clearCountryCurrenciesSearchList();
                        Provider.of<CriptoCurrenciesProvider>(context,
                                listen: false)
                            .clearCriptoCurrenciesSearchList();
                        //Falta la funcion para reference
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          flexibleSpace: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TabBar(
                                indicatorColor: Theme.of(context).primaryColor,
                                labelStyle:
                                    Theme.of(context).textTheme.headline3,
                                labelColor: Theme.of(context).primaryColor,
                                onTap: (value) {
                                  currencyController.clear();
                                  criptoController.clear();
                                  referenceController.clear();
                                  Provider.of<CountriesCurrenciesProvider>(
                                          context,
                                          listen: false)
                                      .clearCountryCurrenciesSearchList();
                                  Provider.of<CriptoCurrenciesProvider>(context,
                                          listen: false)
                                      .clearCriptoCurrenciesSearchList();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                tabs: const [
                                  Tab(text: kCountryTab),
                                  Tab(text: kCriptosTab),
                                  Tab(text: kReferencesTab),
                                ],
                              ),
                            ],
                          ),
                        ),
                        body: TabBarView(children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(kPaddingSearchBox),
                                child: TextField(
                                  style: Theme.of(context).textTheme.headline2,
                                  controller: currencyController,
                                  onChanged: (value) =>
                                      Provider.of<CountriesCurrenciesProvider>(
                                              context,
                                              listen: false)
                                          .searchKeywordOnCountriesList(value),
                                  decoration: InputDecoration(
                                    hintText: kSearchBoxHint,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusSearchBox),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: kIconsSizes,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        currencyController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Provider.of<CountriesCurrenciesProvider>(
                                                context,
                                                listen: false)
                                            .clearCountryCurrenciesSearchList();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: CountryCurrencyListView(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(kPaddingSearchBox),
                                child: TextField(
                                  style: Theme.of(context).textTheme.headline2,
                                  controller: criptoController,
                                  onChanged: (value) =>
                                      Provider.of<CriptoCurrenciesProvider>(
                                              context,
                                              listen: false)
                                          .searchKeywordOnCriptoList(value),
                                  decoration: InputDecoration(
                                    hintText: kSearchBoxHint,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusSearchBox),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: kIconsSizes,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        criptoController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Provider.of<CriptoCurrenciesProvider>(
                                                context,
                                                listen: false)
                                            .clearCriptoCurrenciesSearchList();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: CriptoCurrencyListView(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(kPaddingSearchBox),
                                child: TextField(
                                  style: Theme.of(context).textTheme.headline2,
                                  controller: referenceController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    hintText: kSearchBoxHint,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusSearchBox),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: kIconsSizes,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        referenceController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                  child: Icon(Icons.directions_bike)),
                            ],
                          ),
                        ]),
                      ),
                    ),
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
        Icons.add,
        size: kIconsSizes,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
