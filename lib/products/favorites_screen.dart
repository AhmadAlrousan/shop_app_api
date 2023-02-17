
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shop_Cubit.dart';
import 'package:shop_app_api/bloc/shop_States.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {} ,
        builder:  (context, state){
        return  ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index)=>
                    buildFavItem(ShopCubit.get(context).favorites ,  index , context), //buildCategoryItem(catModel.data.data[index]),

                separatorBuilder: (context , index)=>Divider(),
                itemCount: ShopCubit.get(context).favorites!.length
            ),     fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ) ,
        );
        }

    ) ;
  }

  Widget buildFavItem(List<dynamic>? model , int index  , context)=>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                         model![index]['product']['image'] ,
                    ),

                    width: 120,
                    height: 120,
                  ),
                  //  if (model?.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Discount",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                       "${model[index]['product']['name']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model[index]['product']['price']}",
                          style: TextStyle(fontSize: 12, height: 1.3),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //   if "{(model[index]['discount']}")
                        Text(
                          "${model[index]['product']['old_price']}",
                          style: TextStyle(
                              fontSize: 10,
                              height: 1.3,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Spacer(),
                        IconButton(onPressed: () {
                           ShopCubit.get(context).changeFavorites(model[index]['product']['id']);
                           print("${model[index]['product']['id']}");
                        },
                            icon:CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                ShopCubit.get(context).addFavorites[model[index]['product']['id']] == true?
                               Colors.red:
                              Colors.grey,
                              child: Icon(Icons.favorite_border,size: 14,color: Colors.white,),))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
