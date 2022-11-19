import 'package:the_exchange_app/models/selected_currencies_box.dart';
import 'package:the_exchange_app/provider/countries_currencies_provider.dart';
import 'package:the_exchange_app/provider/cripto_currencies_provider.dart';
import 'package:the_exchange_app/provider/references_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_rates_provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:the_exchange_app/screens/home_page.dart';
import 'package:the_exchange_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('darkThemeSelectedBox');
  Hive.registerAdapter(SelectedCurrenciesBoxAdapter());
  await Hive.openBox<SelectedCurrenciesBox>('selectedCurrenciesBox');
  MobileAds.instance.initialize();
  runApp(const ExchangeApp());
}

class ExchangeApp extends StatelessWidget {
  const ExchangeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedCurrenciesProvider()),
        ChangeNotifierProvider(create: (_) => CountriesCurrenciesProvider()),
        ChangeNotifierProvider(create: (_) => CriptoCurrenciesProvider()),
        ChangeNotifierProvider(create: (_) => ReferenceCurrenciesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => SelectedCurrenciesRatesProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).currentTheme(),
          home: const HomePage(),
        );
      },
    );
  }
}
