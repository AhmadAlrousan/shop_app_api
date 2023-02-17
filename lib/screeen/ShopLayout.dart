import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shop_Cubit.dart';
import 'package:shop_app_api/bloc/shop_States.dart';
import 'package:shop_app_api/component/cons.dart';
import 'package:shop_app_api/screeen/login_Screen.dart';
import 'package:shop_app_api/shared/cache_Helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Salla"),
            actions: [
            //   IconButton(icon: Icon(Icons.search ),
            //     onPressed: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder: (context)
            //   {
            //     return SearchScreen();
            //   }));
            // },) ,
              IconButton(icon: Icon(Icons.logout ),
                onPressed: (){logOut(context);}) ,
            ],

          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
              if(index == 1){
                cubit.getCategoriesData();
              }
            },
            currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home' ,  ),
                BottomNavigationBarItem(icon: Icon(Icons.category),label:'category' ,  ),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label:'favorite' ,  ),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label:'settings' ,  ),

              ],

          ),

        );
      },


    );
  }
}
