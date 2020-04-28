import 'package:flutter/widgets.dart';

class TS24CareFontIcons {
  static const IconData dashboard = const TS24CareIconData(0xe800);
  static const IconData ticket = const TS24CareIconData(0xe803);
  static const IconData notification = const TS24CareIconData(0xe802);
  static const IconData user = const TS24CareIconData(0xe801);
}

class TS24CareIconData extends IconData {
  const TS24CareIconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'TS24Care',
        );
}
