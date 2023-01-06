import 'package:the_exchange_app/models/currencies_box.dart';
import 'package:the_exchange_app/services/countries_currencies_provider.dart';
import 'package:the_exchange_app/services/cripto_currencies_provider.dart';
import 'package:the_exchange_app/services/feedback_provider.dart';
import 'package:the_exchange_app/services/references_currencies_provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/screens/home_page.dart';
import 'package:the_exchange_app/screens/privacy_page.dart';
import 'package:the_exchange_app/screens/terms_page.dart';
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
  await Hive.openBox('firstLoadBox');
  await Hive.openBox('baseSelectedAmount');
  await Hive.openBox('darkThemeSelectedBox');
  await Hive.openBox('englishOptionBox');
  await Hive.openBox('lastUpdateBox');
  Hive.registerAdapter(SelectedCurrenciesBoxAdapter());
  await Hive.openBox<SelectedCurrenciesBox>('currenciesListBox');
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
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ServicesProvider>(context).currentTheme(),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/terms': (context) => const TermsPage(),
            '/priv': (context) => const PrivacyPage(),
          },
        );
      },
    );
  }
}
