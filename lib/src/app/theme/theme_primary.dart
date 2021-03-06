import 'package:flutter/material.dart';

class ThemePrimary {
  static const primaryColor = Color(0xFFd52a26);
  // static const appBarColor = Color(0xFFECF3FD);
  static const appBarColor = Color(0xFF8E8E93);
  static const gradientColor = Color(0xFFc49b29);

  static const colorDriverApp = Color(0xFF007658);

  static const backgroundColor = Colors.white; //Color(0xFFF2F2F2);

  static const backgroundPrimaryColor = Color(0xFFEAEAEA);

  static const primaryFontFamily = "SamsungOne";

  static const appBar_textTheme = TextTheme(
    title: TextStyle(
        fontFamily: primaryFontFamily,
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.bold),
  );
  static const appBar_iconTheme = IconThemeData(color: Colors.white);

  static const Color gradientStart = primaryColor;
  static const Color gradientEnd = gradientColor;

  static const primaryGradient = LinearGradient(
    colors: const [gradientStart, gradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const chatBubbleGradient = const LinearGradient(
    colors: const [Color(0xFFa8ddf7), Color(0xFFa8ddf7)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const chatBubbleGradient2 = const LinearGradient(
    colors: const [Color(0xFFf0edda), Color(0xFFf0edda)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  static theme() {
    return ThemeData(
      fontFamily: "SamsungOne",
      primaryColor: primaryColor,
      //primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.blue,
        actionTextColor: Colors.white,
      ),
      //canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
          color: appBarColor,
          textTheme: appBar_textTheme,
          iconTheme: appBar_iconTheme),
    );
  }

  static TextStyle loginPageButton(BuildContext context) {
    return TextStyle(color: Theme.of(context).primaryColor, fontSize: 15);
  }

  static const history_page_backgroundcolor = Color(0XFFF3F7F6);
}
