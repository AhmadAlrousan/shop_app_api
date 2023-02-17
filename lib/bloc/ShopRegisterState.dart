import 'package:shop_app_api/model/Login_model.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLodingState extends ShopRegisterState{}

class ShopRegisterSuccessState extends ShopRegisterState{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterErrorState(this.error);
}





