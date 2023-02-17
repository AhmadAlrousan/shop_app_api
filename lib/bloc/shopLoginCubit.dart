import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shopLoginState.dart';
import 'package:shop_app_api/model/login_model.dart';
import 'package:shop_app_api/network/End_Points.dart';
import 'package:shop_app_api/network/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit(): super(ShopLoginInitialState());


  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel ;

  void userLogin({
    required String email,
    required String password,

  }){

    emit(ShopLoginLodingState());
    DioHelper.postData(
        url: LOGIN,  // end Point
        data: {
      'email':email,
      'password':password,
    }).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel?.data?.name);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}


