import 'package:shop_app_api/model/login_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLodingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{
  final String error;
  ShopLoginErrorState(this.error);
}



