import 'package:flutter/material.dart';
import 'package:wvems_protocols/_internal/utils/wvems_colors.dart';

class _AppColors {
  static const Color primary = wvemsDarkBlue;
  static const Color primaryDark = wvemsLightBlue;
  static const Color accent = wvemsDarkBlue;
  static const Color accentDark = wvemsLightBlue;
  static const Color greySurface = Color(0xFFE4E4E3);
  static const Color grey = Color(0xFF636463);
  static const Color blackSurface = Color(0xff050505);
  static const Color blackBackground = Color(0xff181818);
  static const Color textDark = Color(0xFF0f0f0f);
  static const Color textLight = Color(0xFFf0f0f0);
}

TextTheme _buildTextTheme() {
  return TextTheme(
    headline1: _style(96.0, FontWeight.normal),
    headline2: _style(60.0, FontWeight.bold),
    headline3: _style(48.0, FontWeight.normal),
    headline4: _style(36.0, FontWeight.bold),
    headline5: _style(30.0, FontWeight.normal),
    headline6: _style(20.0, FontWeight.w500),
    bodyText1: _style(18.0, FontWeight.normal),
    bodyText2: _style(14.0, FontWeight.normal),
    subtitle1: _style(16.0, FontWeight.normal),
    subtitle2: _style(14.0, FontWeight.normal),
    button: _style(18.0, FontWeight.normal),
    caption: _style(12.0, FontWeight.normal),
    overline: _style(16.0, FontWeight.normal),
    // );
  ).apply(fontFamily: 'Barlow');
}

TextStyle _style(double s, FontWeight w) =>
    TextStyle(fontSize: s, fontWeight: w);

// AppTheme inspired by: https://github.com/gskinnerTeam/flokk
// The main exception is that we're using Get instead of Provider for AppTheme
// Thus, we use the ThemeController to directly call AppTheme
// and context.textTheme (instead of Get.textTheme) to ensure the theme is mutable
enum ThemeType { LightMode, DarkMode }

class AppTheme {
  /// Default constructor
  AppTheme({@required this.isDark}) {
    txt = isDark ? _AppColors.textLight : _AppColors.textDark;
    accentTxt =
        accentTxt ?? isDark ? _AppColors.textDark : _AppColors.textLight;
  }

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.LightMode:
        return AppTheme(isDark: false)
          ..bg = _AppColors.greySurface
          ..surface = Colors.white
          ..primary = _AppColors.primary
          ..primaryVariant = _AppColors.primaryDark
          ..secondary = _AppColors.accent
          ..secondaryVariant = _AppColors.accentDark
          ..grey = _AppColors.grey
          ..error = Colors.red.shade900
          ..focus = _AppColors.grey;

      case ThemeType.DarkMode:
        return AppTheme(isDark: true)
          ..bg = _AppColors.blackBackground
          ..surface = _AppColors.blackSurface
          ..primary = _AppColors.primaryDark
          ..primaryVariant = _AppColors.primary
          ..secondary = _AppColors.accentDark
          ..secondaryVariant = _AppColors.accent
          ..grey = _AppColors.grey
          ..error = Colors.red.shade300
          ..focus = _AppColors.grey;
    }
    return AppTheme.fromType(defaultTheme);
  }

  static ThemeType defaultTheme = ThemeType.LightMode;

  bool isDark;
  Color bg;
  Color surface;
  Color primary;
  Color primaryVariant;
  Color secondary;
  Color secondaryVariant;
  Color grey;
  Color error;
  Color focus;

  Color txt;
  Color accentTxt;

  ThemeData get themeData {
    final t = ThemeData.from(
      textTheme: _buildTextTheme(),
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: primary,
          primaryVariant: primaryVariant,
          secondary: secondary,
          secondaryVariant: secondaryVariant,
          background: bg,
          surface: surface,
          onBackground: txt,
          onSurface: txt,
          onError: txt,
          onPrimary: accentTxt,
          onSecondary: accentTxt,
          error: error,
      ),
    );
    return t.copyWith(
        typography: Typography.material2018(),
        accentTextTheme: _buildTextTheme().apply(bodyColor: accentTxt),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionColor: grey,
        textSelectionHandleColor: Colors.transparent,
        buttonColor: primary,
        cursorColor: primary,
        highlightColor: primary,
        toggleableActiveColor: primary);
  }
}
