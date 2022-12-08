import 'package:flutter/material.dart';
import 'package:the_exchange_app/style/theme.dart';

class MainSpace extends StatelessWidget {
  const MainSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: kMainSpace);
  }
}

class SecondarySpace extends StatelessWidget {
  const SecondarySpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: kSecondarySpace);
  }
}
