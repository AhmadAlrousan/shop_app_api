import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme= ThemeData(
  scaffoldBackgroundColor: Colors.white24,
  primaryTextTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18 ,
        fontWeight: FontWeight.w600 , color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    //the theme is changed to dark mode
      color: Colors.black12,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white24,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme:
  BottomNavigationBarThemeData(
      type:BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red[300],
      elevation: 20,
      backgroundColor: Colors.white12,
      unselectedItemColor: Colors.white

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 16 ,
          fontWeight: FontWeight.w600 , color: Colors.white),
      bodyText2: TextStyle(color: Colors.grey)
  ),



);

ThemeData lightTheme= ThemeData(

  appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,

      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme:
  BottomNavigationBarThemeData(
    type:BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue[300],
    elevation: 20,

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 16 ,
          fontWeight: FontWeight.w600 , color: Colors.black),
      bodyText2: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)
  ),
  scaffoldBackgroundColor: Colors.white,
);