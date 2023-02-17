import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/bloc/shop_Cubit.dart';
import 'package:shop_app_api/bloc/shop_States.dart';
import 'package:shop_app_api/model/home_Model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return
          ConditionalBuilder(
            condition:
             ShopCubit.get(context).products !=null && ShopCubit.get(context).categories !=null,
            builder: (context) => builderWidget(
                ShopCubit.get(context).products ,ShopCubit.get(context).categories, context),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                )
        );
      },
    );
  }
    // Widget builderWidget(HomeModel model , CategoriesModel catModel)
  Widget builderWidget(List<dynamic>? model , List<dynamic>? catModel , context ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CarouselSlider(
          //   items: model?.data?.banners
          //       .map(
          //         (e) => Image(
          //           image: NetworkImage('${e.image}'),
          //           width: double.infinity,
          //           fit: BoxFit.cover,
          //         ),
          //       )
          //       .toList(),
          //   options: CarouselOptions(
          //     height: 200,
          //     initialPage: 0,
          //     viewportFraction: 1,
          //     enableInfiniteScroll: true,
          //     reverse: false,
          //     autoPlay: true,
          //     autoPlayInterval: Duration(seconds: 3),
          //     autoPlayAnimationDuration: Duration(seconds: 1),
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Categories",
                  style: TextStyle(fontSize: 24 , fontWeight: FontWeight.w800),),
                Container(
                  height: 100,

                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index)=> buildCategoryItem(catModel , index),
                      //buildCategoryItem(catModel.data.data[index]),
                      separatorBuilder: (context , index)=>SizedBox(width: 10,),
                      itemCount: catModel!.length
                  // itemCount: catModel.data.data.length
                  ),
                ),
                Text("New Products",
                  style: TextStyle(fontSize: 24 , fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white70,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,
              children: List.generate(model!.length,
                  (index) =>
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(
                                   model[index]['image'] ,
                            ),
                            width: double.infinity,
                            height: 200,
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model[index]['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, height: 1.3),
                            ),
                            Row(
                              children: [
                                Text(
                                    "${model[index]['price']}",
                                  style: TextStyle(fontSize: 12, height: 1.3),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              //   if "{(model[index]['discount']}")
                                Text("${model[index]['old_price']}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      height: 1.3,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Spacer(),
                                IconButton(onPressed: () {
                                  ShopCubit.get(context).changeFavorites(model[index]['id']);
                                  print("${model[index]['id']}");
                                },
                                    icon:CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                       ShopCubit.get(context).addFavorites[model[index]['id']] == true?
                                      Colors.red: Colors.grey,
                                      child: Icon(Icons.favorite_border,size: 14,color: Colors.white,),))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
               //       buildGridProduct(model , index)
              ),
            ),
          ),

        ],
      ),
    );
  }
         // buildCategoryItem(DataModel model)
  Widget buildCategoryItem(List<dynamic>? catModel , int index)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [

     // NetworkImage("model.image"),

      Image(image: NetworkImage(catModel?[index]['image']),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
          color: Colors.black.withOpacity(0.6),
          width: 100,
          child: Text(catModel?[index]['name'],style: TextStyle(color: Colors.white),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,))
      //Text(model.name
    ],
  );


  // Widget buildGridProduct(List<dynamic>? model ,int index) =>
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Stack(
  //           alignment: AlignmentDirectional.bottomStart,
  //           children: [
  //             Image(
  //               image: NetworkImage(
  //                 'https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg'
  //            //     model?[index]['image'] ,
  //               ),
  //               width: double.infinity,
  //               height: 200,
  //             ),
  //           //  if (model?.discount != 0)
  //               Container(
  //                 color: Colors.red,
  //                 padding: EdgeInsets.symmetric(horizontal: 5),
  //                 child: Text(
  //                   "Discount",
  //                   style: TextStyle(fontSize: 10, color: Colors.white),
  //                 ),
  //               )
  //           ],
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "model?[index]['name']",
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(fontSize: 14, height: 1.3),
  //               ),
  //               Row(
  //                 children: [
  //                   Text("g",
  //                  //   "model?[index]['price']",
  //                     style: TextStyle(fontSize: 12, height: 1.3),
  //                   ),
  //                   SizedBox(
  //                     width: 5,
  //                   ),
  //                  // if (model?[index]['discount'])
  //                     Text("g",
  //                   //    model?[index]['old_price'],
  //                       style: TextStyle(
  //                           fontSize: 10,
  //                           height: 1.3,
  //                           color: Colors.red,
  //                           decoration: TextDecoration.lineThrough),
  //                     ),
  //                   Spacer(),
  //                   IconButton(onPressed: () {}, icon: Icon(Icons.favorite,size: 14,),)
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );
}
