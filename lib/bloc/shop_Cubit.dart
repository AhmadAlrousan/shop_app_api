
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shop_States.dart';
import 'package:shop_app_api/component/cons.dart';
import 'package:shop_app_api/model/Categories_Model.dart';
import 'package:shop_app_api/model/home_Model.dart';
import 'package:shop_app_api/model/login_model.dart';
import 'package:shop_app_api/network/End_Points.dart';
import 'package:shop_app_api/network/dio_helper.dart';
import 'package:shop_app_api/products/categories_screen.dart';
import 'package:shop_app_api/products/favorites_screen.dart';
import 'package:shop_app_api/products/products_screen.dart';
import 'package:shop_app_api/products/settings_screen.dart';
import 'package:shop_app_api/shared/cache_Helper.dart';

class ShopCubit extends Cubit<ShopStates>
{

  ShopCubit() : super(ShopInitialState());


  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List <Widget> bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    // Give each BottomNavigationBar its own index to display different screens
    currentIndex=index;

    emit(ShopChangeBottomNavState());

  }


//  List<dynamic>? banners;
  List<dynamic>? products;
  Map<int , bool> addFavorites = {};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME , token:token).then((value) {

  //      banners = value.data['data']['banners'];
        products = value.data['data']['products'];
        print("000");

//           print(products?[0]['id']);


        value.data['data']['products'].forEach((element ){

          for(int i =0 ; i<=19 ; i++) {
            addFavorites.addAll(
                {products![i]['id']: products![i]['in_favorites']});
          }
        });

     //   print(addFavorites);


      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
  emit(ShopErrorHomeDataState());
    });
  }


  List<dynamic>? categories;
  void getCategoriesData()
  {

    DioHelper.getData(url: GET_CATEGORIES ).then((value) {

      categories = value.data['data']['data'];
 //    print(value.data['data']['data']);


      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }




  void changeFavorites(int productId)
  {
    addFavorites[productId] == false ? addFavorites[productId]=true : addFavorites[productId]=false;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        } ,
       token: token
    ).then((value)
    {
     // print('000000000000000');
   //   print(value.data['message']);

      // اذا لم يكن هناك token يرحع القيمة كما كانت لمعرفة ان هناك مشكلة
      if(value.data['status'] == false){
        addFavorites[productId] == false ? addFavorites[productId]=true : addFavorites[productId]=false;
      }else{
        getFavoritesData();
      }
    //   addFavorites = value.data[productId]['status'];


  //    emit(ShopSuccessChangeFavoritesState());

    }).catchError((error){

      addFavorites[productId] == false ? addFavorites[productId]=true : addFavorites[productId]=false;
      emit(ShopErrorChangeFavoritesState());
    });
  }


  List<dynamic>? favorites;
  void getFavoritesData()
  {

    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES ,token: token ).then((value) {

      favorites = value.data['data']['data'];

       // print('000000000000000');
       //     print(favorites);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel ;
  List<dynamic>? profile;
  void getUserData()
  {

    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: PROFILE ,token: token ).then((value) {

      // favorites = value.data['data']['data'];
      userModel = ShopLoginModel.fromJson(value.data);
      // print('1111111111');
      // print(userModel?.data?.name);


      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,

  })
  {

    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE ,
        token: token,
        data: {
         'name' : name ,
         'email':email,
         'phone': phone
        }
    ).then((value) {

      // favorites = value.data['data']['data'];
      userModel = ShopLoginModel.fromJson(value.data);
      // print('1111111111');
      // print(userModel?.data?.name);


      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }



}