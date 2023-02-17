import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shop_Cubit.dart';
import 'package:shop_app_api/bloc/shop_States.dart';
import 'package:shop_app_api/model/Categories_Model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {} ,
      builder:  (context, state) {
        return   ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context , index)=>
                buildCatItem(ShopCubit.get(context).categories ,  index), //buildCategoryItem(catModel.data.data[index]),

            //buildCategoryItem(catModel.data.data[index]),
            separatorBuilder: (context , index)=>Divider(),
            itemCount: ShopCubit.get(context).categories!.length
        );
      },

    );
  }

  Widget buildCatItem(List<dynamic>? catModel , int index )=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(catModel?[index]['image']),
          width: 80,
          height: 120,
          fit: BoxFit.cover,

        ),
        SizedBox(width: 20,),
        Text(catModel?[index]['name'] , style: TextStyle(fontSize: 20),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
