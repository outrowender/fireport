import 'package:flutter/material.dart';

abstract class DraculaPalette {
  //https://github.com/dracula/dracula-theme/

  //#282a36 Background
  static Color background = Color.fromRGBO(40, 42, 54, 1);

  //#44475a Current Line
  static Color currentLine = Color.fromRGBO(68, 71, 90, 1);

  //#44475a Selection
  static Color selection = Color.fromRGBO(68, 71, 90, 1);

  //#f8f8f2 Foreground
  static Color foreground = Color.fromRGBO(248, 248, 242, 1);

  //#6272a4 Comment
  static Color comment = Color.fromRGBO(98, 114, 164, 1);

  //#8be9fd Cyan
  static Color cyan = Color.fromRGBO(139, 233, 253, 1);

  //#50fa7b Green
  static Color green = Color.fromRGBO(80, 250, 123, 1);

  //#ffb86c Orange
  static Color orange = Color.fromRGBO(255, 184, 108, 1);

  //#ff79c6 Pink
  static Color pink = Color.fromRGBO(255, 121, 198, 1);

  //#bd93f9 Purple
  static Color purple = Color.fromRGBO(189, 147, 249, 1);

  //#ff5555 Red
  static Color red = Color.fromRGBO(255, 85, 85, 1);

  //#f1fa8c Yellow
  static Color yellow = Color.fromRGBO(241, 250, 140, 1);
}

abstract class DraculaStyles {
  static ThemeData materialTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: DraculaPalette.purple,
    accentColor: DraculaPalette.pink,
    backgroundColor: DraculaPalette.background,
    cursorColor: DraculaPalette.cyan,

    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: DraculaPalette.selection,
      textTheme: TextTheme(
        title: TextStyle(
          color: DraculaPalette.foreground,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      iconTheme: IconThemeData(
        color: DraculaPalette.foreground,
      ),
      actionsIconTheme: IconThemeData(
        color: DraculaPalette.foreground,
      ),
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: DraculaPalette.purple,
      textTheme: ButtonTextTheme.primary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: DraculaPalette.foreground,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: DraculaPalette.currentLine,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: DraculaPalette.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: DraculaPalette.purple,
        ),
      ),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: DraculaPalette.foreground,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: DraculaPalette.purple,
    ),

    snackBarTheme: SnackBarThemeData(
      actionTextColor: DraculaPalette.purple,
      backgroundColor: DraculaPalette.foreground,
    ),

    bottomAppBarTheme: BottomAppBarTheme(
      color: DraculaPalette.selection,
    ),

    textTheme: TextTheme(
      title: TextStyle(
        color: DraculaPalette.foreground,
      ),
      headline: TextStyle(
        color: DraculaPalette.foreground,
      ),
      subhead: TextStyle(
        color: DraculaPalette.foreground,
        //fontStyle: FontStyle.italic,
      ),
      body1: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Hind',
        color: DraculaPalette.foreground,
      ),
      display4: TextStyle(
        color: DraculaPalette.background,
      ),
    ),

    // Define the default font family.
    fontFamily: 'Montserrat',
  );
}
