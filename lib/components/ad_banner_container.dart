import 'package:provider/provider.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerContainer extends StatefulWidget {
  const AdBannerContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<AdBannerContainer> createState() => _AdBannerContainerState();
}

class _AdBannerContainerState extends State<AdBannerContainer> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      // Platform.isAndroid
      //     ? 'ca-app-pub-3940256099942544/6300978111'
      //     : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAdBannerContainerHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: kAdsContainerBorderWidth, color: darkGreen),
          left: BorderSide(width: kAdsContainerBorderWidth, color: darkGreen),
          right: BorderSide(width: kAdsContainerBorderWidth, color: darkGreen),
        ),
      ),
      child: Center(
        child: _anchoredAdaptiveAd != null && _isLoaded
            ? AdWidget(ad: _anchoredAdaptiveAd!)
            : Text(
                Provider.of<ServicesProvider>(context).englishOption
                    ? kLoadingMessage
                    : kEsLoadingMessage,
                style: Theme.of(context).textTheme.headline4,
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}
