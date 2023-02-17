import 'package:shop_app_api/model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);

}

class ShopLoadingGetUserDataState extends ShopStates{}

class ShopErrorGetUserDataState extends ShopStates{}


class ShopSuccessUpdateUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);

}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopErrorUpdateUserDataState extends ShopStates{}


