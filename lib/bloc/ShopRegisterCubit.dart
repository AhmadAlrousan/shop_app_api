

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/ShopRegisterState.dart';
import 'package:shop_app_api/model/Login_model.dart';
import 'package:shop_app_api/network/End_Points.dart';
import 'package:shop_app_api/network/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit(): super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? RegisterModel ;

  void userRegister(
  {
    required String email,
    required String password,
    required String name,
    required String phone,

  }
  ){

    emit(ShopRegisterLodingState());
    DioHelper.postData(
        url: REGISTER,  // end Point
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }).then((value) {

      RegisterModel=ShopLoginModel.fromJson(value.data);
      print(RegisterModel?.data?.name);
      print('11111111111');

      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}
