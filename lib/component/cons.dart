// https://newsapi.org/v2/everything?q=amman&apikey=971b95859440402ba82b82759ad383cc



import 'package:flutter/material.dart';
import 'package:shop_app_api/screeen/login_Screen.dart';
import 'package:shop_app_api/shared/cache_Helper.dart';

void logOut(context){
  CacheHelper.removeData(key:'token').then((value) {
    if(value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return ShopLoginScreen();}));
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) { print(match.group(0));
  });
}


 String token='';


//WYNJ1m7egKH3CjGh8xe7PDIwS0SMdNR76xjx5KdVpYSXFFWn5o8iPuE0r28Zj9zk7S919K
