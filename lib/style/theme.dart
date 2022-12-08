import 'package:flutter/material.dart';

//******************* Color ****************************************/

const Map<int, Color> colorMap = {
  50: Color.fromRGBO(147, 205, 72, .1),
  100: Color.fromRGBO(147, 205, 72, .2),
  200: Color.fromRGBO(147, 205, 72, .3),
  300: Color.fromRGBO(147, 205, 72, .4),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(147, 205, 72, 1),
};

MaterialColor darkGreenMaterial = const MaterialColor(0xFF10332d, colorMap);
MaterialColor middleGreenMaterial = const MaterialColor(0xFF264d48, colorMap);

const Color darkYellow = Color(0xFFff9700);
const Color lightYellow = Color(0xFFffba01);
const Color midleWhite = Color.fromARGB(161, 237, 230, 204);
const Color darkWhite = Color(0xFFede6cc);
const Color lightGreen = Color(0xFF5cb08c);
const Color midleGreen = Color(0xFF264d48);
const Color darkGreen = Color(0xFF10332d);
const Color transparentColor = Colors.transparent;
const Color darkDropdown = Color(0xFF193330);
const Color lightDropdown = Color(0xFF94907f);

//******************* Sizes ****************************************/

const double kIconsSizes = 30.0;

//Search Box Component
const double kPaddingSearchBox = 8.0;
const double kBorderRadiusSearchBox = 12.0;
const EdgeInsetsGeometry kSearchBoxDimensions =
    EdgeInsets.symmetric(vertical: 17, horizontal: 10);
const EdgeInsetsGeometry kSDescriptionBoxDimensions =
    EdgeInsets.symmetric(vertical: 35, horizontal: 10);

//Currencies List Tile
const double kElevationCurrencyCard = 10.0;
const double kFlagImageWidth = 53.0;
const double kFlagImageHeight = 40.0;
const double kRightSpaceOnCurrencyCardIcon = 19.0;
const double kMainCardBorderRadius = 10.0;
const double kMainCardBorderWidth = 2.0;
const double kPaddingLeftReorderableDrag = 12.0;
const double kPaddingRightReorderableDrag = 5.0;
const double kVerticalPaddingTitleTile = 8.0;
const double kHorizantalPaddingTitleTile = 15.0;

//Ads Component
const double kAdBannerContainerHeight = 60.0;
const double kAdsContainerBorderWidth = 2.0;
const int kAdDialogContainerInt = 250;
const double kAdDialogContainerDouble = 250.0;

//Bottom Sheet Component
const double kBottomSheetHeight = 0.8;
const double kBottomSheetBorderRadius = 15.0;
const double kPaddingRightButton = 10.0;
const double kPaddingTopButton = 5.0;
const double kSpaceBetweenButtons = 7.0;
const double kBottomSheetSizedBox = 0.57;
const double kBottomSheetFeedbackSizedBox = 0.69;
const double kSpaceBetweenTextFieldMin = 2.0;
const double kSpaceBetweenTextField = 5.0;
const double kSpaceBetweenTextFieldMax = 10.0;
const double kSpaceLeftText = 15.0;
const double kElevatedButtonWidth = 80.0;
const double kElevatedButtonHeight = 37.0;
const double kCircularProgressIndicatorSquare = 16.0;
const double kCircularProgressIndicatorStroke = 3.0;

//Main Circular Progress Indicator
const double kSquareCircularProgressIndicator = 77.0;
const double kStrokeCircularProgressIndicator = 7.0;

//Home Screen
const double kSizedBoxHeight = 15.0;

//Drawer Component
const double kDrawerWidth = 0.6;

//Toast Component
const double kToastText = 17;

//Dropdown Component
const double kBorderWidthDropdown = 1.2;

//License Image
const double kLicenseImageWidth = 99;
const double kLicenseImageHeight = 35;

//Terms Page
const double kPaddingPage = 15;
const double kMainSpace = 20;
const double kSecondarySpace = 15;

//Help Page
const double kPaddingHelpPage = 20;

//******************* Text Styles *********************************/

const TextStyle appBarTitleTextStyle = TextStyle(
  color: darkWhite,
  fontSize: 19,
  fontFamily: 'SF-UI-DISPLAY',
  fontWeight: FontWeight.w600,
);

const TextStyle appBarSubtitleTextStyle = TextStyle(
  fontSize: 17,
  fontFamily: 'SF-UI-DISPLAY',
  fontWeight: FontWeight.w500,
);

ThemeData customDarkTheme = ThemeData(
  primarySwatch: darkGreenMaterial,
  scaffoldBackgroundColor: midleGreen,
  primaryColor: darkWhite,
  hoverColor: darkGreen,
  fontFamily: 'SF-UI-DISPLAY',
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: darkWhite,
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
    headline2: TextStyle(
      color: darkWhite,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    headline3: TextStyle(
      color: darkWhite,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
    headline4: TextStyle(
      color: midleWhite,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    headline5: TextStyle(
      color: darkWhite,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      color: darkWhite,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      color: lightYellow,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    subtitle2: TextStyle(
      color: darkWhite,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
);

ThemeData customLightTheme = ThemeData(
  primarySwatch: middleGreenMaterial,
  scaffoldBackgroundColor: darkWhite,
  primaryColor: darkGreen,
  hoverColor: midleGreen,
  fontFamily: 'SF-UI-DISPLAY',
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: darkGreen,
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),
    headline2: TextStyle(
      color: darkGreen,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    headline3: TextStyle(
      color: darkGreen,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
    headline4: TextStyle(
      color: midleGreen,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    headline5: TextStyle(
      color: darkGreen,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      color: darkWhite,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      color: lightYellow,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    subtitle2: TextStyle(
      color: darkGreen,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
);
