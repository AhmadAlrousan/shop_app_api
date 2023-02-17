import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/cubit.dart';
import 'package:shop_app_api/bloc/cubit22.dart';
import 'package:shop_app_api/bloc/shop_Cubit.dart';
import 'package:shop_app_api/bloc/states22.dart';
import 'package:shop_app_api/component/cons.dart';
import 'package:shop_app_api/network/End_Points.dart';
import 'package:shop_app_api/screeen/ShopLayout.dart';
import 'package:shop_app_api/screeen/login_Screen.dart';
import 'package:shop_app_api/screeen/onBoarding.dart';
import 'package:shop_app_api/styles/theme.dart';


import 'shared/cache_Helper.dart';
import 'network/MyBlocOserver.dart';
import 'network/dio_helper.dart';

void main() async{
  // Make sure everything is done, then open the application
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.init();

  // Here the value is returned
  bool? isDark = await CacheHelper.getDataTheme(key: "isDark");

  Widget widget;

  bool? onBoarding = await CacheHelper.getData(key: "onBoarding");
   token = await CacheHelper.getData(key: "token")??"";
   print(token);



  if(onBoarding !=null){

    if(token != null) {
      widget = ShopLayout();

    }

  else {
      widget = ShopLoginScreen();

    }
  }

  else {
    widget=OnBoardingScreen();
  }

 // widget=ShopLayout();

  runApp( MyApp(
    isDark,
     widget
  ));
}

class MyApp extends StatelessWidget {
  late bool isDark;

  late Widget startWidget;

  MyApp(this.isDark , this.startWidget);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubet()
          ..getBusiness()..getSport()..getScience(),),
        BlocProvider(create: (BuildContext context)=>AppCubit()
          ..changeAppMode(
            fromShared: isDark,
          ),),
        BlocProvider(create: (BuildContext context)=>ShopCubit()..getHomeData().. getCategoriesData()..getFavoritesData()..getUserData(),
         ),
     //   getCategoriesData()..getFavoritesData()..getHomeData()
      ],
      child: BlocConsumer<AppCubit ,AppState>(
        listener: (context, state){},
        builder: (context , state){
          return  MaterialApp(
            title: 'Shop app APIS',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme:darkTheme,
            // i cull up the cubit and cull isDark of boolean
            // When isDark is true, the screen turns into Dark mode and vice versa
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
           home:startWidget


          );
        },

      ),
    );
  }

}
