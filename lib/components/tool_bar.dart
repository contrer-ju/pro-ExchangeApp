import 'package:the_exchange_app/components/icon_of_update.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget with PreferredSizeWidget {
  const ToolBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.menu,
            size: kIconsSizes,
            color: darkWhite,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      title: const Text(
        kAppTitle,
        style: appBarTitleTextStyle,
      ),
      actions: const <Widget>[
        UpdateIcon(),
      ],
    );
  }
}
