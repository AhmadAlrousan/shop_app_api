import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/states.dart';

import '../network/dio_helper.dart';

class NewsCubet extends Cubit<NewsStates>{
  NewsCubet(): super(NewsInitialState());

  static NewsCubet get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItems=[
    // Here are the properties for each BottomNavigationBar
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Busines',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Scirnce',

    ),


  ];

  List<Widget> screens=[
    // Give each BottomNavigationBar its own screen

  ];

  void changeBottomNavBar(int index){
    // Give each BottomNavigationBar its own index to display different screens
    currentIndex=index;
    if(index==1)
      getSport();
    else if(index==2)
      getScience();
    emit(NewsBottomNavState());

  }

  List<dynamic> business= [];
  // Here the data is called from the api
  void getBusiness(){
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',  // call api
      query: {
        'country':'eg',
        'category':'business',
        'apikey': '971b95859440402ba82b82759ad383cc',
      },
    ).then((value) {
      business= value.data['articles']; //The data is saved inside business
      print(business[0]['title']);
      emit(NewsGetBusinessState());
    }).catchError((error){
      print("erroe ${error.toString()}");
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sport= [];

  void getSport(){
    emit(NewsSportLoadingState());

    if(sport.length==0){
      DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey': '971b95859440402ba82b82759ad383cc',
        },
      ).then((value) {
        //   print(value?.data['articles'][0]['title']);
        sport= value.data['articles'];
        print(sport[0]['title']);
        emit(NewsGetSportState());
      }).catchError((error){
        print("erroe ${error.toString()}");
        emit(NewsGetSportErrorState(error.toString()));
      });
    }else {
      emit(NewsGetSportState());

    }

  }

  List<dynamic> science= [];

  void getScience(){
    emit(NewsScinceLoadingState());
    if(science.length ==0){

      DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey': '971b95859440402ba82b82759ad383cc',
        },
      ).then((value) {
        //   print(value?.data['articles'][0]['title']);
        science= value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScinceState());
      }).catchError((error){
        print("erroe ${error.toString()}");
        emit(NewsGetScinceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScinceState());

    }

  }


  List<dynamic> search= [];

  void getSearch(String value) {
    emit(NewsSearchLoadingState());

    search = [];

    // DioHelper is called to grab all Data to display in search
    DioHelper.getData(url: 'v2/everything',
      query: {
        'q':'$value',
        'apikey': '971b95859440402ba82b82759ad383cc',
      },
    ).then((value) {

      search= value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchState());
    }).catchError((error){
      print("error000000000 ${error.toString()}");
      emit(NewsGetSearchErrorState(error.toString()));

    });



}
}
