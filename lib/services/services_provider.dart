import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ServicesProvider extends ChangeNotifier {
  bool darkThemeSelected =
      Hive.box('darkThemeSelectedBox').get('value') ?? false;
  bool englishOption = Hive.box('englishOptionBox').get('value') ?? false;

  late TutorialCoachMark tutorialCoachMark;
  GlobalKey keyAddButton = GlobalKey();
  GlobalKey keyDeleteButton = GlobalKey();
  GlobalKey keyUpdateButton = GlobalKey();
  GlobalKey keyCalculateBase = GlobalKey();
  GlobalKey keyCalculateList = GlobalKey();
  GlobalKey keyPutOnTopOfList = GlobalKey();
  GlobalKey keyShareRate = GlobalKey();
  GlobalKey keyMoveOnTheList = GlobalKey();

  bool thereIsbase = false;
  bool thereIsList = false;

  ThemeData currentTheme() {
    return darkThemeSelected ? customDarkTheme : customLightTheme;
  }

  void switchTheme() {
    darkThemeSelected = !darkThemeSelected;
    notifyListeners();
  }

  void saveTheme() {
    Hive.box('darkThemeSelectedBox').put('value', darkThemeSelected);
  }

  void switchLanguage() {
    englishOption = !englishOption;
    notifyListeners();
  }

  void saveLanguage() {
    Hive.box('englishOptionBox').put('value', englishOption);
  }

  void checkCurrenciesList(bool checkIfThereIsbase, bool checkIfThereIsList) {
    thereIsbase = checkIfThereIsbase;
    thereIsList = checkIfThereIsList;
  }

  void initTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: lightDropdown,
      hideSkip: true,
      paddingFocus: kPaddingFocus,
      opacityShadow: kOpacityShadow,
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        keyTarget: keyAddButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kAddButtonTitle,
                kEsAddButtonTitle,
                kAddButtonMessage,
                kEsAddButtonMessage,
                true,
                false,
              );
            },
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyDeleteButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kDeleteButtonTitle,
                kEsDeleteButtonTitle,
                kDeleteButtonMessage,
                kEsDeleteButtonMessage,
                false,
                false,
              );
            },
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyUpdateButton,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kUpdateButtonTitle,
                kEsUpdateButtonTitle,
                kUpdateButtonMessage,
                kEsUpdateButtonMessage,
                false,
                thereIsbase ? false : true,
              );
            },
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyCalculateBase,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kCalculateBaseTitle,
                kEsCalculateBaseTitle,
                kCalculateBaseMessage,
                kEsCalculateBaseMessage,
                false,
                thereIsList ? false : true,
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        paddingFocus: kRectPaddingFocus,
        radius: kRectBorderRadius,
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyCalculateList,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kCalculateListTitle,
                kEsCalculateListTitle,
                kCalculateListMessage,
                kEsCalculateListMessage,
                false,
                false,
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        paddingFocus: kRectPaddingFocus,
        radius: kRectBorderRadius,
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyPutOnTopOfList,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kPutOnTopOfListTitle,
                kEsPutOnTopOfListTitle,
                kPutOnTopOfListMessage,
                kEsPutOnTopOfListMessage,
                false,
                false,
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        paddingFocus: kRectPaddingFocus,
        radius: kRectBorderRadius,
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyShareRate,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kShareRateTitle,
                kEsShareRateTitle,
                kShareRateMessage,
                kEsShareRateMessage,
                false,
                false,
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        paddingFocus: kRectPaddingFocus,
        radius: kRectBorderRadius,
      ),
    );

    targets.add(
      TargetFocus(
        keyTarget: keyMoveOnTheList,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return targetContentTemplate(
                controller,
                kMoveOnTheListTitle,
                kEsMoveOnTheListTitle,
                kMoveOnTheListMessage,
                kEsMoveOnTheListMessage,
                false,
                true,
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        paddingFocus: kRectPaddingFocus,
        radius: kRectBorderRadius,
      ),
    );

    return targets;
  }

  Column targetContentTemplate(
      TutorialCoachMarkController controller,
      String enTitle,
      String esTitle,
      String enMessage,
      String esMessage,
      bool isFirst,
      bool isLast) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          englishOption ? enTitle : esTitle,
          style: targetContentTitle,
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: kPaddingMessage, bottom: kPaddingMessage),
          child: Text(
            englishOption ? enMessage : esMessage,
            style: targetContentMessage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingButtonsRow),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: isFirst ? null : () => controller.previous(),
                child: const Icon(Icons.chevron_left),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.skip();
                },
                child: const Icon(Icons.close),
              ),
              ElevatedButton(
                onPressed: isLast ? null : () => controller.next(),
                child: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
