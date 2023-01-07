import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdDialogContainer extends StatefulWidget {
  const AdDialogContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<AdDialogContainer> createState() => _AdDialogContainerState();
}

class _AdDialogContainerState extends State<AdDialogContainer> {
  BannerAd? _squareAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    _squareAd = BannerAd(
      adUnitId: 'ca-app-pub-8848305379460757/3561172182',
      // adUnitId: Platform.isAndroid
      //     ? 'ca-app-pub-3940256099942544/6300978111'
      //     : 'ca-app-pub-3940256099942544/2934735716',
      size: const AdSize(
          width: kAdDialogContainerInt, height: kAdDialogContainerInt),
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );

    return _squareAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAdDialogContainerDouble,
      width: kAdDialogContainerDouble,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: kAdsContainerBorderWidth, color: darkGreen),
      ),
      child: Center(
        child: _squareAd != null && _isLoaded
            ? AdWidget(ad: _squareAd!)
            : CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _squareAd?.dispose();
  }
}
