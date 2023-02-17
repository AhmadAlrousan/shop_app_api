


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/states22.dart';

import '../shared/cache_Helper.dart';


class AppCubit extends Cubit<AppState>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark=true;
// ThemeMode appMode=ThemeMode.dark;
// ThemeMode appMode1=ThemeMode.light;

  // Created a new cubit
  // A method change App Mod was created to change Them Data
  void changeAppMode({bool? fromShared}){

    if(fromShared != null)
    {
      isDark=fromShared;
      emit(AppChangeModeState());

    }
    else{
      isDark=!isDark;

      // Here the value is saved
      CacheHelper.setData(key: "isDark", value: isDark).then((value) {
        print(isDark.toString());
        emit(AppChangeModeState());
      });
    }



  }


}
















