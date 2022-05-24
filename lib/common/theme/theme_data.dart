part of 'theme.dart';

ThemeData defaultTheme() {
  return ThemeData(
    fontFamily: MyFontFamily.graphik,
    accentColor: ThemeColor.primary,
    primaryColor: ThemeColor.primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
