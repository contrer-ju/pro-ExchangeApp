import 'package:the_exchange_app/components/list_view_country_currency.dart';
import 'package:the_exchange_app/components/list_view_cripto_currency.dart';
import 'package:the_exchange_app/components/list_view_reference_currency.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/countries_currencies_provider.dart';
import 'package:the_exchange_app/services/cripto_currencies_provider.dart';
import 'package:the_exchange_app/services/references_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
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
      key: Provider.of<ServicesProvider>(context).keyAddButton,
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
                        Provider.of<ServicesProvider>(context).englishOption
                            ? kBottomSheetButton
                            : kEsBottomSheetButton,
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
                        Provider.of<ReferenceCurrenciesProvider>(context,
                                listen: false)
                            .clearReferenceCurrenciesSearchList();
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
                                  Provider.of<ReferenceCurrenciesProvider>(
                                          context,
                                          listen: false)
                                      .clearReferenceCurrenciesSearchList();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                tabs: [
                                  Tab(
                                      text: Provider.of<ServicesProvider>(context)
                                              .englishOption
                                          ? kCountryTab
                                          : kEsCountryTab),
                                  Tab(
                                      text: Provider.of<ServicesProvider>(context)
                                              .englishOption
                                          ? kCryptosTab
                                          : kEsCryptosTab),
                                  Tab(
                                      text: Provider.of<ServicesProvider>(context)
                                              .englishOption
                                          ? kReferencesTab
                                          : kEsReferencesTab),
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
                                    hintText:
                                        Provider.of<ServicesProvider>(context)
                                                .englishOption
                                            ? kSearchBoxHint
                                            : kEsSearchBoxHint,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusSearchBox),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Provider.of<CountriesCurrenciesProvider>(
                                                        context)
                                                    .countrySearchKeyword ==
                                                ""
                                            ? Icons.search
                                            : Icons.clear,
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
                                    hintText:
                                        Provider.of<ServicesProvider>(context)
                                                .englishOption
                                            ? kSearchBoxHint
                                            : kEsSearchBoxHint,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusSearchBox),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Provider.of<CriptoCurrenciesProvider>(
                                                        context)
                                                    .criptoSearchKeyword ==
                                                ""
                                            ? Icons.search
                                            : Icons.clear,
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
                                  onChanged: (value) {
                                    Provider.of<ReferenceCurrenciesProvider>(
                                            context,
                                            listen: false)
                                        .searchKeywordOnReferenceList(value);
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        Provider.of<ServicesProvider>(context)
                                                .englishOption
                                            ? kSearchBoxHint
                                            : kEsSearchBoxHint,
                                    hintStyle:
                                        Theme.of(context).textTheme.headline4,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kBorderRadiusSearchBox),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Provider.of<ReferenceCurrenciesProvider>(
                                                        context)
                                                    .referenceSearchKeyword ==
                                                ""
                                            ? Icons.search
                                            : Icons.clear,
                                        size: kIconsSizes,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        referenceController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Provider.of<ReferenceCurrenciesProvider>(
                                                context,
                                                listen: false)
                                            .clearReferenceCurrenciesSearchList();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: ReferenceCurrencyListView(),
                              ),
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
      backgroundColor: Provider.of<ServicesProvider>(context).darkThemeSelected
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
